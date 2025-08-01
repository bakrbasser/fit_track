part of 'days_list_cubit.dart';

@immutable
sealed class DaysListState {}

final class DaysListInitial extends DaysListState {}

final class Loading extends DaysListState {}

final class EmptyList extends DaysListState {}

final class FullList extends DaysListState {
  List<TrainingDay?> days;
  List<int> counts;

  FullList({required this.days, required this.counts});
}
