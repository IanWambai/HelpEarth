import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(new MaterialApp(
      theme: ThemeData(fontFamily: 'Blogger Sans'),
      home: new TellCompaniesPage()));
}

class TellCompaniesPage extends StatefulWidget {
  @override
  TellCompaniesPageState createState() => new TellCompaniesPageState();
}

class TellCompaniesPageState extends State<TellCompaniesPage> {
  @override
  Widget build(BuildContext context) {
    return _getList(context, _getCompanies());
  }

  _getCompanies() {
    final icons = [
      Icons.directions_bike,
      Icons.directions_boat,
      Icons.directions_bus,
      Icons.directions_car,
    ];
    final titles = [
      'A.P. Moller – Maersk',
      'Airbus Group',
      'American Electric Power Company, Inc.',
      'Anglo American',
      'Anhui Conch Cement',
      'ArcelorMittal',
      'BASF SE',
      'Bayer AG',
      'Berkshire Hathaway',
      'BHP Billiton',
      'Boeing Company',
      'BP',
      'Canadian Natural Resources Limited',
      'Caterpillar Inc.',
      'Centrica',
      'Chevron Corporation',
      'China Petroleum & Chemical Corporation',
      'China Shenhua Energy',
      'CNOOC',
      'Coal India',
      'ConocoPhillips',
      'Cummins Inc.',
      'Daikin Industries, Ltd.',
      'Duke Energy Corporation',
      'E.ON SE',
      'Ecopetrol Sa',
      'EDF',
      'ENEL SpA',
      'ENGIE',
      'Eni SpA',
      'Equinor',
      'Exelon Corporation',
      'Exxon Mobil Corporation',
      'Fiat Chrysler Automobiles NV',
      'Ford Motor Company',
      'Formosa Petrochemical',
      'Gas Natural SDG SA',
      'General Electric Company',
      'General Motors Company',
      'Glencore plc',
      'Hitachi, Ltd.',
      'Hon Hai Precision Industry',
      'Honda Motor Company',
      'Imperial Oil',
      'Ingersoll-Rand Co. Ltd.',
      'International Paper Company',
      'JX Holdings Inc',
      'Koninklijke Philips NV',
      'Korea Electric Power Corp',
      'LafargeHolcim Ltd',
      'Lockheed Martin Corporation',
      'Lukoil OAO',
      'LyondellBasell Industries Cl A',
      'Marathon Petroleum',
      'Martin Marietta Materials, Inc.',
      'MMC Norilsk Nickel OSJC',
      'Nestlé',
      'Nippon Steel & Sumitomo Metal Corporation',
      'Nissan Motor Co., Ltd.',
      'NTPC Ltd',
      'Oil & Natural Gas',
      'OMV AG',
      'PACCAR Inc',
      'Panasonic Corporation',
      'PepsiCo Inc.',
      'PETROCHINA Company Limited',
      'Petróleo Brasileiro SA – Petrobras',
      'Phillips 66',
      'PJSC Gazprom',
      'POSCO',
      'Procter & Gamble Company',
      'PTT',
      'Reliance Industries',
      'Repsol',
      'Rio Tinto',
      'Rolls-Royce',
      'Rosneft Oil Company',
      'Royal Dutch Shell',
      'Saic Motor Corporation',
      'Sasol Limited',
      'Siemens AG',
      'SK Innovation Co Ltd',
      'Southern Copper Corporation',
      'Suncor Energy Inc.',
      'Suzuki Motor Corporation',
      'Teck Resources Limited',
      'Tesoro Corporation',
      'The Dow Chemical Company',
      'The Southern Company',
      'thyssenkrupp AG',
      'Toray Industries Inc.',
      'Total',
      'Toyota Motor Corporation',
      'United Technologies Corporation',
      'Vale',
      'Valero Energy Corporation',
      'Vedanta Ltd',
      'Volkswagen AG',
      'Volvo',
      'Wesfarmers'
    ];
    final descriptions = [
      'Lorem ipsum dolor sit amet',
      'Lorem ipsum dolor sit amet',
      'Lorem ipsum dolor sit amet',
      'Lorem ipsum dolor sit amet'
    ];
    final pages = [4, 5, 6, 7];

    List<Row> companies = List<Row>();
    for (int i = 0; i < titles.length; i++) {
      companies.add(new Row(icons[0], titles[i], descriptions[0], pages[0]));
    }

    return companies;
  }
}

// ignore: must_be_immutable
class SendMessagePage extends StatefulWidget {
  String title;

  SendMessagePage(String title) {
    this.title = title;
  }

  @override
  SendMessagePageState createState() => new SendMessagePageState(title);
}

class SendMessagePageState extends State<SendMessagePage> {
  String title;

  SendMessagePageState(String title) {
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
              )
            ],
          ),
        )));
  }
}

class Row {
  final IconData icon;
  final String title;
  final String description;
  final int page;

  Row(this.icon, this.title, this.description, this.page);
}

Widget _getList(BuildContext context, List<Row> rows) {
  return new Scaffold(
      appBar: AppBar(title: const Text('Help Earth')),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          return Card(
            child: _getListTile(context, rows[index].icon, rows[index].title,
                rows[index].description, rows[index].page),
          );
        },
      ));
}

ListTile _getListTile(BuildContext context, IconData icon, String title,
    String description, int page) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    subtitle: Text(description),
    trailing: Icon(Icons.keyboard_arrow_right),
    onTap: () {
      switch (page) {
        case 0:
          _openPage(context, TellCompaniesPage());
          break;
        case 1:
          _openPage(context, TellCompaniesPage());
          break;
        case 2:
          _openPage(context, SendMessagePage(title));
          break;
        case 3:
          _openPage(context, TellCompaniesPage());
          break;
        case 4:
          _openPage(context, SendMessagePage(title));
          break;
        case 5:
          _openPage(context, SendMessagePage(title));
          break;
        case 6:
          _openPage(context, SendMessagePage(title));
          break;
        case 7:
          _openPage(context, SendMessagePage(title));
          break;
        case 8:
          _openPage(context, SendMessagePage(title));
          break;
        case 9:
          _openPage(context, SendMessagePage(title));
          break;
        case 10:
          _openPage(context, SendMessagePage(title));
          break;
        case 11:
          _openPage(context, SendMessagePage(title));
          break;
      }
    },
  );
}

_openPage(BuildContext context, StatefulWidget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
