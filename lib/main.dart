import 'package:flutter/material.dart';
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
  int timeWeHaveLeft = 0;
  int progressSinceReportWasReleased = 0;
  
  int currentTimeCount = 0;
  int timeCountOilAndGas = 0;
  int timeCountAgriculture = 0;

  final stepInMilliseconds = 1;

  CountdownTimerPageState() {
    processCurrentTime();
    setupCountdownTimer();
  }

  processCurrentTime() async {
    DateTime reportReleaseDate = DateTime(2018, 10, 8);
    DateTime deadline = DateTime(2030, 1, 1);
    DateTime now = DateTime.now();

    timeWeHaveLeft = deadline.difference(now).inSeconds;
    int timeSinceReportWasReleased = deadline.difference(reportReleaseDate).inSeconds;
    progressSinceReportWasReleased = 100 - ((timeWeHaveLeft / timeSinceReportWasReleased) * 100).toInt();
  }

  setupCountdownTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(new Duration(seconds: timeWeHaveLeft), new Duration(milliseconds: stepInMilliseconds));

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      currentTimeCount += stepInMilliseconds;
      this.onTimerTick(currentTimeCount);
    });

    sub.onDone(() {
      sub.cancel();
    });
  }

  void onTimerTick(int currentNumber) {
    setState(() {
      currentNumber = currentNumber;
      timeCountOilAndGas += 1;
      timeCountAgriculture += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("###,###,###,###,###,###");
    int number = timeWeHaveLeft - currentTimeCount;
    number += stepInMilliseconds;

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
            style: new TextStyle(
                color: Colors.red, fontSize: 48.0, fontWeight: FontWeight.bold),
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
              top: 64.0, bottom: 64.0, left: 64.0, right: 64.0),
          child: Text(
            'If time runs out, life permanently gets worse. We\'re already out of time.',
            style: new TextStyle(color: Colors.black, fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
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
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: new Text(
                            'Oil & Gas',
                            style: new TextStyle(
                                color: Colors.white, fontSize: 24.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        new Text(
                          timeCountOilAndGas.toString() + ' tons of Carbon so far',
                          style: new TextStyle(
                              color: Colors.white, fontSize: 14.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                onPressed: () {
                  _doSomething(context);
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(12.0))),
          ),
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
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: new Text(
                            'Agriculture',
                            style: new TextStyle(
                                color: Colors.white, fontSize: 24.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        new Text(
                          timeCountAgriculture.toString() + ' tons of Carbon so far',
                          style: new TextStyle(
                              color: Colors.white, fontSize: 14.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                onPressed: () {
                  _doSomething(context);
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(12.0))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 64.0),
          child: Center(
            child: GestureDetector(
              onTap: () {
                _launchURL("https://climate.nasa.gov/scientific-consensus/");
              },
              child: new Text(
                'Read The Research',
                style: new TextStyle(color: Colors.black, fontSize: 20.0),
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

  _doSomething(BuildContext context) {
//    Navigator.of(context)
//        .push(MaterialPageRoute(builder: (context) => DoSomethingPage()));
  }
}

//class DoSomethingPage extends StatefulWidget {
//
//}
