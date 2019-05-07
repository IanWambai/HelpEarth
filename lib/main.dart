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

  int timeWeHaveLeft = 0;
  int progressSinceReportWasReleased = 0;
  int currentNumber = 0;
  final stepInSeconds = 1;

  CountdownTimerPageState() {
    processCurrentTime();
    setupCountdownTimer();
    _processAnimation();
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
        body: new Container(
            child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            _openAboutPage(context);
          },
          child: Stack(alignment: AlignmentDirectional.center, children: [
            FluttieAnimation(animation, size: const Size(200.0, 200.0)),
            Padding(
              padding: const EdgeInsets.only(left: 148.0, top: 42),
              child: Image.asset('assets/information.png',
                  width: 16.0,
                  height: 16.0,
                  fit: BoxFit.cover,
                  color: Colors.grey),
            )
          ]),
        ),
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
                  currentValue: progressSinceReportWasReleased,
                  displayText: '%',
                  size: 8,
                  borderRadius: 4,
                  progressColor: Colors.red,
                  backgroundColor: Colors.cyan,
                ),
              ),
              Text(
                'seconds left to Help Earth.',
                style: new TextStyle(color: Colors.black, fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 64, bottom: 32),
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
        duration: const Duration(seconds: 60),
        repeatCount: const RepeatCount.infinite(),
        repeatMode: RepeatMode.START_OVER);
    animation.start();
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
