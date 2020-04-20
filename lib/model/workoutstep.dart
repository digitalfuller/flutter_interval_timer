class WorkoutStep {
  Duration duration;
  String title;
  WorkoutStep(this.duration, this.title);
  WorkoutStep.prepare(this.duration) {
    title = "Prepare";
  }
  WorkoutStep.work(this.duration) {
    title = "Work";
  }
  WorkoutStep.rest(this.duration) {
    title = "Rest";
  }
  WorkoutStep.recover(this.duration) {
    title = "Recover";
  }
}
