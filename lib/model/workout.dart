import 'package:interval_timer/model/workoutconfiguration.dart';
import 'package:interval_timer/model/workoutstep.dart';

class Workout {
  List<WorkoutStep> _steps = List<WorkoutStep>();

  Workout(WorkoutConfiguration workoutConfiguration) {
    _steps = _createWorkoutSteps(workoutConfiguration);
  }

  Duration get totalTime => _steps
      .map((w) => w.duration)
      .fold(Duration.zero, (previous, current) => previous + current);

  int _stepIndexAtTime(Duration time) {
    var currentTime = totalTime - time + Duration(seconds: 1);
    var stepTimeEndTime = Duration.zero;
    for (int i = 0; i < _steps.length; i++) {
      stepTimeEndTime += _steps[i].duration;
      if (currentTime <= stepTimeEndTime) {
        return i;
      }
    }
    return _steps.length;
  }

  WorkoutStep currentStep(Duration time) {
    return _steps[_stepIndexAtTime(time)];
  }

  WorkoutStep nextStep(Duration time) {
    var next = _stepIndexAtTime(time) + 1;
    if(next < _steps.length)
      return _steps[next];
    return WorkoutStep(Duration.zero, 'Done');
  }

  Iterable<WorkoutStep> _createWorkoutSteps(
      WorkoutConfiguration workoutConfiguration) {
    List<WorkoutStep> workoutSteps = List<WorkoutStep>();

    workoutSteps
        .add(WorkoutStep.prepare(workoutConfiguration.preparationDuration));
    workoutSteps.addAll(_createStepsForRepeats(workoutConfiguration));

    return workoutSteps;
  }

  Iterable<WorkoutStep> _createStepsForRepeats(WorkoutConfiguration workout) {
    List<WorkoutStep> workoutSteps = List<WorkoutStep>();

    var repeats = workout.repeats;
    for (int i = 0; i < repeats; i++) {
      workoutSteps.addAll(_createStepsForExercises(workout));
      if (repeats > 1 && i < repeats - 1) {
        workoutSteps.add(WorkoutStep.recover(workout.recoveryDuration));
      }
    }
    return workoutSteps;
  }

  Iterable<WorkoutStep> _createStepsForExercises(WorkoutConfiguration workout) {
    var totalSteps = workout.workSteps * 2 - 1;

    return Iterable.generate(totalSteps, (int i) {
      var workoutPhase = WorkoutStep.work(workout.workDuration);

      if (i % 2 != 0 && i < totalSteps) {
        workoutPhase = WorkoutStep.rest(workout.restDuration);
      }

      return workoutPhase;
    });
  }
}
