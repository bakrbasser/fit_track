part of 'add_plan_cubit.dart';

@immutable
sealed class AddPlanState {}

final class AddPlanInitial extends AddPlanState {}

final class AddedPlan extends AddPlanState {
  final TrainingPlan plan;

  AddedPlan({required this.plan});
}

final class Error extends AddPlanState {
  final String message;

  Error({required this.message});
}
