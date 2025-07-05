part of 'plans_list_cubit.dart';

@immutable
sealed class PlansListState {}

final class PlansListInitial extends PlansListState {}

final class Loading extends PlansListState {}

final class EmptyList extends PlansListState {}

final class FullList extends PlansListState {
  final List<TrainingPlan> plans;

  FullList({required this.plans});
}
