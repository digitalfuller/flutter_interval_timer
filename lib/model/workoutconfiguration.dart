class WorkoutConfiguration {
  final Duration preparationDuration;
  final Duration workDuration;
  final Duration restDuration;
  final int workSteps;
  final int repeats;
  final Duration recoveryDuration;

  WorkoutConfiguration(this.preparationDuration, this.workDuration,
      this.restDuration, this.workSteps, this.repeats, this.recoveryDuration);

  WorkoutConfiguration.fromDefaults()
      : preparationDuration = Duration(seconds: 10),
        workDuration = Duration(seconds: 10),
        restDuration = Duration(seconds: 5),
        workSteps = 3,
        repeats = 1,
        recoveryDuration = Duration(seconds: 10);
}