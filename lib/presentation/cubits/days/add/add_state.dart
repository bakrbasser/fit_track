part of 'add_day_cubit.dart';

@immutable
sealed class AddDayState {}

final class AddInitial extends AddDayState {}

final class AddedDay extends AddDayState {
  final TrainingDay day;

  AddedDay({required this.day});
}

final class Error extends AddDayState {
  final String message;

  Error({required this.message});
}
