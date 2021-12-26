import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:task_timer_flutter_project/MyWidgets/button_widget.dart';

class TimerCard extends StatefulWidget {
  final bool autoStart;
  final bool ended;
  final Duration cContent;
  final sTimer;
  final endTimer;
  const TimerCard(
      {Key? key,
      required this.sTimer,
      this.endTimer,
      this.ended = false,
      this.autoStart = false,
      required this.cContent})
      : super(key: key);

  @override
  _TimerCardState createState() => _TimerCardState(
        autoStart,
        cContent,
        sTimer,
        endTimer,
        ended,
      );
}

class _TimerCardState extends State<TimerCard> {
  final bool ended;
  final sTimer;
  final endTimer;
  final bool autoStart;
  final Duration cContent;
  _TimerCardState(
    this.autoStart,
    this.cContent,
    this.sTimer,
    this.endTimer,
    this.ended,
  );
  Duration myDuration = Duration();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    if (autoStart) {
      startTimer(true);
    } else {
      reset();
    }
  }

  void reset() {
    setState(() => myDuration = cContent);
    timer?.cancel();
  }

  void subTime() {
    final subSeconds = -1;
    setState(() {
      final mySecond = myDuration.inSeconds + subSeconds;

      if (mySecond < 0) {
        endTimer(myDuration.inMilliseconds);
        timer?.cancel();
      } else {
        myDuration = Duration(seconds: mySecond);
      }
    });
  }

  void startTimer(bool autoStarted) {
    reset();
    timer = Timer.periodic(Duration(seconds: 1), (_) => subTime());
    if (!autoStarted) {
      sTimer();
    }
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    setState(() => timer?.cancel());
    endTimer(myDuration.inMilliseconds);
  }

  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTimeCard(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.005),
            buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildTimeCard() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final myHours = twoDigits(myDuration.inHours);
    final myMinutes = twoDigits(myDuration.inMinutes.remainder(60));
    final mySeconds = twoDigits(myDuration.inSeconds.remainder(60));
    return AutoSizeText(
      '$myHours:$myMinutes:$mySeconds',
      maxFontSize: 60,
      minFontSize: 30,
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
      ),
    );
  }

  Widget buildCard({required String time, required String header}) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AutoSizeText(
              time,
              maxFontSize: 60,
              minFontSize: 30,
              style: TextStyle(
                fontSize: 60,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.012),
          Text(
            header,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  Widget buildButtons() {
    final isRunning = timer == null || ended ? false : timer!.isActive;
    final isToStart = myDuration.inSeconds == cContent.inSeconds && !ended;
    return isToStart
        ? ButtonWidget(
            onClicked: () {
              startTimer(false);
            },
            color: Colors.black,
            bgcolor: Colors.white,
            text: 'Start',
          )
        : ButtonWidget(
            onClicked: () {
              stopTimer(resets: false);
            },
            text: isRunning ? 'STOP' : 'Ended',
            disabled: !isRunning,
          );
  }
}
