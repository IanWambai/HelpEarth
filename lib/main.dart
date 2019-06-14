import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiver/async.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(new MaterialApp(
      theme: ThemeData(fontFamily: 'Blogger Sans'),
      home: new CountdownTimerPage()));
}

class CountdownTimerPage extends StatefulWidget {
  @override
  CountdownTimerPageState createState() => new CountdownTimerPageState();
}

class CountdownTimerPageState extends State<CountdownTimerPage> {
  int timeWeHaveLeft = 0;
  int progressSinceReportWasReleased = 0;
  int currentNumber = 0;
  final stepInSeconds = 1;

  CountdownTimerPageState() {
    processCurrentTime();
    setupCountdownTimer();
  }

  processCurrentTime() async {
    DateTime reportReleaseDate = DateTime(2018, 10, 8);
    DateTime deadline = DateTime(2030, 1, 1);
    DateTime now = DateTime.now();

    timeWeHaveLeft = deadline.difference(now).inSeconds;
    int timeSinceReportWasReleased =
        deadline.difference(reportReleaseDate).inSeconds;
    progressSinceReportWasReleased =
        100 - ((timeWeHaveLeft / timeSinceReportWasReleased) * 100).toInt();
  }

  setupCountdownTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
        new Duration(seconds: timeWeHaveLeft),
        new Duration(seconds: stepInSeconds));

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      currentNumber += stepInSeconds;

      this.onTimerTick(currentNumber);
    });

    sub.onDone(() {
      sub.cancel();
    });
  }

  void onTimerTick(int currentNumber) {
    setState(() {
      currentNumber = currentNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("###,###,###,###,###,###");
    int number = timeWeHaveLeft - currentNumber;
    number += stepInSeconds;

    return new Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 64.0, right: 64.0),
          child: Text(
            'We have',
            style: new TextStyle(color: Colors.black, fontSize: 22.0),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
          child: Text(
            formatter.format(number),
            style: new TextStyle(color: Colors.black, fontSize: 48.0),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          'seconds to Help Earth.',
          style: new TextStyle(color: Colors.black, fontSize: 22.0),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 64.0, bottom: 72.0, left: 64.0, right: 64.0),
          child: Text(
            'If time runs out, life permanently gets worse. We\'re already out of time.',
            style: new TextStyle(color: Colors.black, fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 64.0),
          child: Center(
            child: GestureDetector(
              onTap: () {
                _launchURL("https://climate.nasa.gov/scientific-consensus/");
              },
              child: new Text(
                'Read The Research',
                style: new TextStyle(color: Colors.black, fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Container(
          height: 200.0,
          width: 200.0,
          decoration: new BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Share.share('We have ' +
                    formatter.format(timeWeHaveLeft) +
                    ' seconds left to #HelpEarth. If Time runs out, life as you know it will permanently change for the worse.\n\nWe Are Already Out Of Time.');
              },
              child: new Text(
                'Do Something',
                style: new TextStyle(color: Colors.white, fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    ));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openAboutPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SecondRoute()));
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Help Earth"),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 64, bottom: 32),
        child: Text(
          'If Time runs out, life as you know it will permanently change for the worse.',
          style: new TextStyle(color: Colors.black, fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
