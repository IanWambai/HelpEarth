import 'package:flutter/material.dart';
import 'package:fluttie/fluttie.dart';
import 'package:help_earth/progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:quiver/async.dart';
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
  FluttieAnimationController animation;

  final timeOutInSeconds = 315569520;
  final stepInSeconds = 1;
  int currentNumber = 0;

  CountdownTimerPageState() {
    setupCountdownTimer();
    _processAnimation();
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
    final formatter = new NumberFormat("###,###,###,###,###,###");
    int number = timeOutInSeconds - currentNumber;
    number += stepInSeconds;

    return new Scaffold(
        body: new Container(
            child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FluttieAnimation(animation, size: const Size(160.0, 160.0)),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32, bottom: 32),
          child: Column(
            children: <Widget>[
              Text(
                'According to scientific reports, we have',
                style: new TextStyle(color: Colors.black, fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22.0),
                child: Text(
                  formatter.format(number),
                  style: new TextStyle(color: Colors.cyan, fontSize: 48.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 22.0),
                child: FAProgressBar(
                  currentValue: 80,
                  displayText: '%',
                  size: 8,
                  borderRadius: 4,
                  progressColor: Colors.cyan,
                  backgroundColor: Colors.red,
                ),
              ),
              Text(
                'seconds left to Help Earth.',
                style: new TextStyle(color: Colors.black, fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 56, bottom: 32),
                child: Text(
                  'If Time runs out, life as you know it will permanently change for the worse.',
                  style: new TextStyle(color: Colors.black, fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 36.0),
          child: Center(
            child: GestureDetector(
              onTap: () {
                _launchURL("https://climate.nasa.gov/scientific-consensus/");
              },
              child: new Text(
                'Read The Research',
                style: new TextStyle(color: Colors.cyan, fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Container(
          color: Colors.cyan,
          height: 100,
          child: Center(
            child: GestureDetector(
              onTap: () {
                _launchURL(
                    "http://www.preventclimatechange.co.uk/prevent-climate-change.html");
              },
              child: new Text(
                'Do Something',
                style: new TextStyle(color: Colors.white, fontSize: 32.0),
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

  _processAnimation() async {
    var instance = Fluttie();
    var composition =
        await instance.loadAnimationFromAsset("assets/help_earth_logo.json");
    animation = await instance.prepareAnimation(composition,
        duration: const Duration(seconds: 90),
        repeatCount: const RepeatCount.infinite(),
        repeatMode: RepeatMode.START_OVER);
    animation.start();
  }
}
