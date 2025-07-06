part of 'add_cubit.dart';

@immutable
sealed class AddState {}

final class AddInitial extends AddState {}

final class AddedDay extends AddState {
  final TrainingDay day;

  AddedDay({required this.day});
}

final class Error extends AddState {
  final String message;

  Error({required this.message});
}
