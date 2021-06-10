import 'dart:async';

import 'package:cupertino_datepicker_example/utils.dart';
import 'package:cupertino_datepicker_example/widget/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimerPickerPage extends StatefulWidget {
  @override
  _TimerPickerPageState createState() => _TimerPickerPageState();
}

class _TimerPickerPageState extends State<TimerPickerPage> {
  Duration duration = Duration(hours: 1, minutes: 6, seconds: 30);
  int _seconds = 30;
  int _minutes = 6;
  int _hours = 1;
  String _textHolder = 'Start';
  Timer? _timer;
  var f = NumberFormat("00");

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void _startTimer() {
    if (_timer != null) {
      setState(() {
        _textHolder = 'Resume';
      });
      _stopTimer();
      return;
    }

    setState(() {
      _textHolder = 'Pause';
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _seconds = 59;
            _minutes--;
          } else {
            if (_hours > 0) {
              _minutes = 59;
              _seconds = 59;
              _hours--;
            } else {
              _timer!.cancel();
              print("Timer Complete");
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTimePicker(),
              const SizedBox(height: 24),
              ButtonWidget(onClicked: () {
                _hours = duration.inHours;
                _minutes = duration.inMinutes.remainder(60);
                _seconds = duration.inSeconds.remainder(60);

                _startTimer();
              }),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${f.format(_hours)} : ${f.format(_minutes)} : ${f.format(_seconds)}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 48,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () {
                      _startTimer();
                    },
                    color: Colors.orange[300],
                    shape: CircleBorder(side: BorderSide(color: Colors.orange)),
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Text(
                        '$_textHolder',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildTimePicker() => SizedBox(
        height: 180,
        child: CupertinoTimerPicker(
          initialTimerDuration: duration,
          mode: CupertinoTimerPickerMode.hms,
          minuteInterval: 1,
          secondInterval: 1,
          onTimerDurationChanged: (duration) =>
              setState(() => this.duration = duration),
        ),
      );
}
