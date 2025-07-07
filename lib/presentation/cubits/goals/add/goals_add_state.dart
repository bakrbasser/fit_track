part of 'goals_add_cubit.dart';

@immutable
sealed class GoalsAddState {}

final class GoalsAddInitial extends GoalsAddState {}

final class AddedGoal extends GoalsAddState {}

final class Error extends GoalsAddState {
  final String message;

  Error({required this.message});
}
