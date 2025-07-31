part of 'charts_cubit.dart';

@immutable
sealed class ChartsState {}

final class ChartsInitial extends ChartsState {}

final class ChartLoading extends ChartsState {}

final class ChartFinishedLoading extends ChartsState {}

final class ChartReady extends ChartsState {
  final List<double> data;
  final String title;
  final String subTitle;

  ChartReady({required this.data, required this.title, required this.subTitle});
}
