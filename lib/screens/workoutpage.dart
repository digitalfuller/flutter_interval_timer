import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interval_timer/model/workout.dart';
import 'package:interval_timer/model/workoutstep.dart';
import 'package:interval_timer/util/DurationFormat.dart';

class WorkoutPage extends StatefulWidget {
  final Workout workout;
  WorkoutPage(this.workout);

  @override
  _WorkoutPageState createState() => _WorkoutPageState(workout);
}

class _WorkoutPageState extends State<WorkoutPage> {
  Workout _workout;
  Duration _workoutRemainingTime;
  Duration _currentStepRemainingTime;
  Duration _currentStepTotalTime;
  WorkoutStep _currentStep;
  WorkoutStep _nextStep;
  Duration _elapsedTime = Duration.zero;
  static Duration _timerTick = Duration(seconds: 1);
  bool _timerRunning;

  final Stream _timer = Stream.periodic(_timerTick);
  StreamSubscription _timerSubscription;

  _WorkoutPageState(this._workout);

  @override
  void initState() {
    super.initState();

    _timerRunning = false;
    _workoutRemainingTime = _workout.totalTime;
    _currentStep = _workout.currentStep(_workoutRemainingTime);
    _nextStep = _workout.nextStep(_workoutRemainingTime);
    _currentStepTotalTime = _currentStep.duration;
    _currentStepRemainingTime = _currentStepTotalTime;

    print("_workoutRemainingTime: $_workoutRemainingTime");
    print("_currentStep: ${_currentStep.title}");
    print("_nextStep: ${_nextStep.title}");
    print("_currentStepRemainingTime: $_currentStepRemainingTime");

    _timerSubscription = _timer.listen((event) {
      if (_workoutRemainingTime > Duration.zero) {
        setState(() {
          _elapsedTime += _timerTick;
          _workoutRemainingTime = _workoutRemainingTime - _timerTick;
          _currentStepRemainingTime = _currentStepRemainingTime - _timerTick;
          print(
              "_workoutRemainingTime: $_workoutRemainingTime _elapsedTime: $_elapsedTime");
          if (_workoutRemainingTime == Duration.zero) {
            print("stopping timer: $_workoutRemainingTime");
            _stopTimer();
          } else {
            _currentStep = _workout.currentStep(_workoutRemainingTime);
            print("_currentStep: ${_currentStep.title}");

            if (_currentStep == _nextStep) {
              _currentStepRemainingTime = _currentStep.duration;
            }
            print("_currentStepRemainingTime: $_currentStepRemainingTime");

            _nextStep = _workout.nextStep(_workoutRemainingTime);
            print("_nextStep: ${_nextStep.title}");
          }
        });
      }
    });

    _startTimer();
  }

  @override
  void dispose() {
    _timerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
            child: Container(
      child: Column(
        children: <Widget>[
          Text(
              "${DurationFormat.minutesAndSeconds(_workoutRemainingTime)} - ${DurationFormat.minutesAndSeconds(_workout.totalTime)}"),
          if (_currentStep != null)
            Text(
                "${_currentStep.title} for: ${DurationFormat.minutesAndSeconds(_currentStepRemainingTime)} - ${DurationFormat.minutesAndSeconds(_currentStep.duration)}"),
          if (_nextStep != null)
            Text(
                "Up next: ${_nextStep.title} for ${DurationFormat.minutesAndSeconds(_nextStep.duration)}"),
          IconButton(
            icon: Icon(_timerRunning
                ? Icons.pause_circle_outline
                : Icons.play_circle_outline),
            onPressed: () {
              _timerRunning ? _stopTimer() : _startTimer();
            },
          )
        ],
      ),
    )));
  }

  void _stopTimer() {
    _timerSubscription.pause();
    setState(() {
      _timerRunning = false;
    });
  }

  void _startTimer() {
    if (_workoutRemainingTime > Duration.zero) {
      _timerSubscription.resume();
      setState(() {
        _timerRunning = true;
      });
    }
  }
}
