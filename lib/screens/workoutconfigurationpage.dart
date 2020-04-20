import 'package:flutter/material.dart';
import 'package:interval_timer/model/workout.dart';
import 'package:interval_timer/model/workoutconfiguration.dart';
import 'package:interval_timer/screens/workoutpage.dart';
import 'package:interval_timer/util/DurationFormat.dart';

class WorkoutConfigurationPage extends StatefulWidget {
  WorkoutConfigurationPage({Key key}) : super(key: key);

  @override
  _WorkoutConfigurationPageState createState() => _WorkoutConfigurationPageState();
}

class _WorkoutConfigurationPageState extends State<WorkoutConfigurationPage> {

  static WorkoutConfiguration workoutConfiguration = WorkoutConfiguration.fromDefaults();
  Workout workout = Workout(workoutConfiguration);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 80.0, bottom: 30.0),
              child: Center(
                child: Text(DurationFormat.minutesAndSeconds(workout.totalTime),
                style: TextStyle(fontSize: 50.0),),
                
              ),
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.play_circle_outline)),
                title: Text('Preparation'),
                trailing: Text(DurationFormat.minutesAndSeconds(workoutConfiguration.preparationDuration)),
              ),
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.play_circle_outline)),
                title: Text('Work'),
                trailing: Text(DurationFormat.minutesAndSeconds(workoutConfiguration.workDuration)),
              ),
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.pause_circle_outline)),
                title: Text('Rest'),
                trailing: Text(DurationFormat.minutesAndSeconds(workoutConfiguration.restDuration)),
              ),
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.check_circle_outline)),
                title: Text('Exercises'),
                trailing: Text(workoutConfiguration.workSteps.toString()),
              ),
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.refresh)),
                title: Text('Repeats'),
                trailing: Text("${workoutConfiguration.repeats}X"),
              ),
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.timer)),
                title: Text('Recovery'),
                trailing:
                    Text(DurationFormat.minutesAndSeconds(workoutConfiguration.recoveryDuration)),
              ),
            ),
            Center(
              child: IconButton(
                icon: Icon(Icons.play_circle_filled),
                iconSize: 50.0,
                onPressed: () {
                  navigateToWorkoutPage(workout);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToWorkoutPage(Workout workout) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WorkoutPage(workout)),
    );
  }
}
