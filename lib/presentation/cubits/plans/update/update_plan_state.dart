part of 'update_plan_cubit.dart';

@immutable
sealed class UpdatePlanState {}

final class UpdatePlanInitial extends UpdatePlanState {}

final class Error extends UpdatePlanState {
  final String message;

  Error({required this.message});
}

final class UpdatePlan extends UpdatePlanState {}
