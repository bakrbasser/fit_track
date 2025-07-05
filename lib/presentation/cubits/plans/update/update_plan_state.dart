part of 'update_plan_cubit.dart';

@immutable
sealed class UpdatePlanState {}

final class UpdatePlanInitial extends UpdatePlanState {}

final class UpdatePlan extends UpdatePlanState {}
