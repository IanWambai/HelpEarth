import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(new MaterialApp(
      theme: ThemeData(fontFamily: 'Primer'), home: new CountdownTimerPage()));
}

class CountdownTimerPage extends StatefulWidget {
  @override
  CountdownTimerPageState createState() => new CountdownTimerPageState();
}

class CountdownTimerPageState extends State<CountdownTimerPage> {
  final timeOutInSeconds = 10;
  final stepInSeconds = 1;
  int currentNumber = 0;

  CountdownTimerPageState() {
    setupCountdownTimer();
  }

  setupCountdownTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
        new Duration(seconds: timeOutInSeconds),
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
    int number = timeOutInSeconds - currentNumber;
    // Make it start from the timeout value
    number += stepInSeconds;
    return new Scaffold(
        body: new Container(
            child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 64),
          child: Center(
            child: new Text(
              'According to the latest scientific reports, we have $number seconds left to help Earth.\n\n\nWhen it reaches 0, there is nothing we could do to avoid the Climate Change catastrophe.',
              style: new TextStyle(color: Colors.black, fontSize: 26.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: GestureDetector(
              onTap: () {
                _launchURL("https://climate.nasa.gov/scientific-consensus/");
              },
              child: new Text(
                'Read The Research',
                style: new TextStyle(color: Colors.cyan, fontSize: 26.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: GestureDetector(
              onTap: () {
                _launchURL("http://www.preventclimatechange.co.uk/prevent-climate-change.html");
              },
              child: new Text(
                'Do Something',
                style: new TextStyle(color: Colors.cyan, fontSize: 32.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    )));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
