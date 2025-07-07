part of 'goals_list_cubit.dart';

@immutable
sealed class GoalsListState {}

final class GoalsListInitial extends GoalsListState {}

final class Loading extends GoalsListState {}

final class EmptyList extends GoalsListState {}

final class FullList extends GoalsListState {
  final List<Goal> goals;

  FullList({required this.goals});
}
