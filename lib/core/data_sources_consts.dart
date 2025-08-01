class TablesName {
  /// Table for storing exercise information
  static String get exercises => 'exercise';

  /// Table for storing exercise goals
  static String get goals => 'goal';

  /// Table for logging completed exercises
  static String get exerciseLogs => 'exercise_log';

  /// Table for training day definitions
  static String get trainingDays => 'training_day';

  /// Table for training plan definitions
  static String get trainingPlans => 'training_plan';

  /// Junction table linking training plans to training days
  static String get trainingPlanTrainingDay => 'trainingPlan_trainingDay';

  /// Junction table linking training days to exercises
  static String get trainingDayExercise => 'trainingDay_exercise';
}

class BoxesNames {
  static String get nextDay => 'NextDay';
}
