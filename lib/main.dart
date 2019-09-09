import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(new MaterialApp(
      theme: ThemeData(
          fontFamily: 'Blogger Sans', primaryColor: Color(0xFFFFFFFF)),
      home: new ViewRepresentatives()));
}

class ViewRepresentatives extends StatefulWidget {
  @override
  ViewRepresentativesState createState() => new ViewRepresentativesState();
}

class ViewRepresentativesState extends State<ViewRepresentatives> {
  @override
  Widget build(BuildContext context) {
    return _getList(context, _getRepresentatives());
  }

  _getRepresentatives() {
    final ids = ["id1", "id2", "id3", "id4"];
    final icons = [
      'https://www.kbl.co.uk/wp-content/uploads/2017/11/Default-Profile-Male.jpg',
      'https://www.kbl.co.uk/wp-content/uploads/2017/11/Default-Profile-Male.jpg',
      'https://www.kbl.co.uk/wp-content/uploads/2017/11/Default-Profile-Male.jpg',
      'https://www.kbl.co.uk/wp-content/uploads/2017/11/Default-Profile-Male.jpg'
    ];
    final titles = ['Sub Chief', 'Chief', 'Women\'s Rep', 'Governer'];
    final coordinates = ['2 km', '5 km', '18 km', '37 km'];
    final descriptions = [
      'Your current Sub Chief is John Doe',
      'Your current Chief is John Doe',
      'Your current Women\'s Rep is Jane Doe',
      'Your current Governer is John Doe'
    ];

    List<ListItem> representatives = List<ListItem>();
    for (int i = 0; i < titles.length; i++) {
      representatives.add(new ListItem(
          ids[i], icons[i], titles[i], coordinates[i], descriptions[i]));
    }

    return representatives;
  }
}

// ignore: must_be_immutable
class MessagePage extends StatefulWidget {
  String title;

  MessagePage(String title) {
    this.title = title;
  }

  @override
  MessagePageState createState() => new MessagePageState(title);
}

class MessagePageState extends State<MessagePage> {
  String title;

  MessagePageState(String title) {
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    String message =
        "Dear [name]\n\nI am writing to express my concern about the imminent threat climate change poses to our country, to our people and the future of our children. An overwhelming number of scientists agree, and signs abound that climate change is occurring much faster than was initially predicted. We have only a few critical years before the changes become irreversible.\n\nMore than 2,000 scientists contributing to the Intergovernmental Panel on Climate Change (IPCC) have made it clear that cuts of at least 50% to 70% in global greenhouse gas emissions are necessary to allow our climate to re-stabilise. Therefore, the Government should be making every effort to reduce greenhouse gas emissions – now.\n\nSpecifically, I believe you should act to address the issues below, and I ask you to provide me with information on what the government is doing to reduce greenhouse gas emissions in the following areas:\n\n1. Reducing carbon dioxide emissions from coal fired power plants\n2. Reducing emissions from the transport sector\n3. Funding initiatives for alternative and renewable energy technology\n4. Incentives for the uptake of renewable energy\n5. Removal of subsidies for fossil based fuel sources\n\nTo secure a future for our nation and our children now is the time to set a new and positive direction for our national energy policy. We need policies that will lead our nation away from fossil based fuels.\n\nOur addiction to fossil fuel harms human health, causes global warming, degrades land and marine ecosystems, and pollutes the earth. We need energy systems that provide clean, renewable, and reliable energy that does not threaten human health or the environment. We do create our futures, and not to reach for it would be a gross abdication of our moral responsibility.\n\nI understand that focusing on climate change is just one of many issues during these challenging times. However, we can not wait until tomorrow we must take strong action now to address the daunting issues that climate change poses.\n\nSincerely\n\n[your name]";

    return new Scaffold(
        appBar: AppBar(title: const Text('Help Earth')),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              new Text(title, style: new TextStyle(fontSize: 16.0)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(message, style: new TextStyle(fontSize: 12.0)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Center(
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.red,
                      child: Container(
                        width: 256,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: new Text(
                                  'Send Message',
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 24.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {
                        Share.share(message);
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(12.0))),
                ),
              ),
            ],
          ),
        )));
  }
}

class ListItem {
  final String id;
  final String icon;
  final String title;
  final String coordinates;
  final String description;

  ListItem(this.id, this.icon, this.title, this.coordinates, this.description);
}

Widget _getList(BuildContext context, List<ListItem> representatives) {
  return new Scaffold(
      appBar: AppBar(
          title: Padding(
        padding: const EdgeInsets.only(right: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: new Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              'https://www.kbl.co.uk/wp-content/uploads/2017/11/Default-Profile-Male.jpg')))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: new Text(
                '#HelpEarth',
                style: new TextStyle(color: Colors.black87, fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 6, right: 6),
              child: new Container(
                  width: 3.0,
                  height: 3.0,
                  decoration: new BoxDecoration(
                      color: Colors.grey, shape: BoxShape.circle)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: new Text(
                'Nairobi',
                style: new TextStyle(color: Colors.grey, fontSize: 18.0),
              ),
            ),
          ],
        ),
      )),
      body: ListView.separated(
          itemCount: representatives.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: _getListTile(context, representatives[index]),
            );
          },
          separatorBuilder: (context, index) => Divider(
                color: Color(0xFFe3e3e3),
              )));
}

ListTile _getListTile(BuildContext context, ListItem representative) {
  return ListTile(
    leading: new Container(
        width: 64.0,
        height: 64.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(representative.icon)))),
    title: _getTitle(representative.title, representative.coordinates),
    subtitle: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(representative.description),
    ),
    trailing: Icon(Icons.keyboard_arrow_right),
    onTap: () {
      _openPage(context, MessagePage(representative.title));
    },
  );
}

Widget _getTitle(String title, String time) {
  return Row(
    children: <Widget>[
      new Text(
        title,
        style: new TextStyle(color: Colors.black87, fontSize: 16.0),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 6, right: 6),
        child: new Container(
            width: 3.0,
            height: 3.0,
            decoration:
                new BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
      ),
      new Text(
        time,
        style: new TextStyle(color: Colors.grey, fontSize: 14.0),
      ),
    ],
  );
}

_openPage(BuildContext context, StatefulWidget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

// ignore: unused_element
_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
