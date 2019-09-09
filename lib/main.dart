import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

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
    final names = ['John Doe', 'James Doi', 'Jane Dear', 'Jake Dol'];
    final coordinates = ['2 km', '5 km', '18 km', '37 km'];
    final emailAddresses = [
      'Your current Sub Chief is John Doe',
      'Your current Chief is John Doe',
      'Your current Women\'s Rep is Jane Doe',
      'Your current Governer is John Doe'
    ];
    final phoneNumbers = [
      'Your current Sub Chief is John Doe',
      'Your current Chief is John Doe',
      'Your current Women\'s Rep is Jane Doe',
      'Your current Governer is John Doe'
    ];

    List<RepresentativeItem> representatives = List<RepresentativeItem>();
    for (int i = 0; i < titles.length; i++) {
      representatives.add(new RepresentativeItem(ids[i], icons[i], titles[i],
          names[i], coordinates[i], emailAddresses[i], phoneNumbers[i]));
    }

    return representatives;
  }
}

class RepresentativeItem {
  final String id;
  final String image;
  final String title;
  final String name;
  final String coordinates;
  final String emailAddress;
  final String phoneNumber;

  RepresentativeItem(this.id, this.image, this.title, this.name,
      this.coordinates, this.emailAddress, this.phoneNumber);
}

Widget _getList(
    BuildContext context, List<RepresentativeItem> representatives) {
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
                style: new TextStyle(
                    color: Colors.black87,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
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

ListTile _getListTile(BuildContext context, RepresentativeItem representative) {
  return ListTile(
    leading: new Container(
        width: 64.0,
        height: 64.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(representative.image)))),
    title: _getTitle(representative.title, representative.coordinates),
    subtitle: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text('Your current ' +
          representative.title +
          ' is ' +
          representative.name),
    ),
    trailing: Icon(Icons.keyboard_arrow_right),
    onTap: () {
      _openPage(context, MessagePage(representative));
    },
  );
}

Widget _getTitle(String title, String time) {
  return Row(
    children: <Widget>[
      new Text(
        title,
        style: new TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
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

// ignore: must_be_immutable
class MessagePage extends StatefulWidget {
  RepresentativeItem representative;

  MessagePage(RepresentativeItem representative) {
    this.representative = representative;
  }

  @override
  MessagePageState createState() => new MessagePageState(representative);
}

class MessagePageState extends State<MessagePage> {
  RepresentativeItem representative;
  List issues = [
    'Climate Change',
    'Corruption',
    'Health Care',
    'Education',
    'Employment'
  ];
  List<DropdownMenuItem<String>> dropDownMenuItems;
  String currentIssue;

  @override
  void initState() {
    dropDownMenuItems = getDropDownMenuItems();
    currentIssue = dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String issue in issues) {
      items.add(new DropdownMenuItem(value: issue, child: new Text(issue)));
    }
    return items;
  }

  MessagePageState(RepresentativeItem representative) {
    this.representative = representative;
  }

  @override
  Widget build(BuildContext context) {
    String message = "Dear " +
        representative.name +
        ",\n\nI understand that focusing on climate change is just one of many issues during these challenging times. However, we can not wait until tomorrow we must take strong action now to address the daunting issues that climate change poses I understand that focusing on climate change is just one of many issues during these challenging times.\n\nHowever, we can not wait until tomorrow we must take strong action now to address the daunting issues that climate change poses. I understand that focusing on climate change is just one of many issues during these challenging times.\n\nHowever, we can not wait until tomorrow we must take strong action now to address the daunting issues that climate change poses. I understand that focusing on climate change is just one of many issues during these challenging times. However, we can not wait until tomorrow we must take strong action now to address the daunting issues that climate change poses.\n\nI understand that focusing on climate change is just one of many issues during these challenging times. However, we can not wait until tomorrow we must take strong action now to address the daunting issues that climate change poses.";
    final TextEditingController controller = TextEditingController();
    controller.text = message;

    return new Scaffold(
        appBar: AppBar(title: Text(representative.title), actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.red,
            ),
            onPressed: () {
              Share.share(message);
            },
          ),
        ]),
        body: Center(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: new Container(
                  width: 72.0,
                  height: 72.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(representative.image)))),
            ),
            Text(representative.name,
                style:
                    new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: new Text(
                        'Select a letter to send your ' + representative.title),
                  ),
                  new DropdownButton(
                    value: currentIssue,
                    items: dropDownMenuItems,
                    onChanged: changedDropDownItem,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  decoration: new BoxDecoration(
                      color: Color(0xFFe6e6e6),
                      borderRadius:
                          new BorderRadius.all(Radius.circular(16.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                ),
              ),
            )
          ],
        )));
  }

  void changedDropDownItem(String selectedIssue) {
    setState(() {
      currentIssue = selectedIssue;
    });
  }
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
