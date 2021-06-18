import 'dart:async';

import 'package:cupertino_datepicker_example/widget/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimerPickerPage extends StatefulWidget {
  @override
  _TimerPickerPageState createState() => _TimerPickerPageState();
}

class _TimerPickerPageState extends State<TimerPickerPage> {
  Duration duration = Duration(hours: 0, minutes: 0, seconds: 0);
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  String _textHolder = 'Start';
  Timer? _timer;
  Color _colorPauseButton = Colors.black;

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

  Color getPauseButtonColor() {
    return _colorPauseButton;
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

                _colorPauseButton = Colors.white;
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${f.format(_hours)} : ${f.format(_minutes)} : ${f.format(_seconds)}",
                    style: TextStyle(
                      color: Colors.white,
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
                    color: getPauseButtonColor(),
                    shape: CircleBorder(side: BorderSide(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(38.0),
                      child: Text(
                        '$_textHolder',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
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
        child: DefaultTextStyle.merge(
          // style: TextStyle(fontSize: 20, color: Colors.white),
          child: CupertinoTimerPicker(
            backgroundColor: Colors.blue[100],
            initialTimerDuration: duration,
            mode: CupertinoTimerPickerMode.hms,
            minuteInterval: 1,
            secondInterval: 1,
            onTimerDurationChanged: (duration) =>
                setState(() => this.duration = duration),
          ),
        ),
        height: 180,
      );
}
