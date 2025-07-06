part of 'initialization_cubit.dart';

@immutable
sealed class InitializationState {}

final class InitializationInitial extends InitializationState {}

final class Initializing extends InitializationState {}

final class Initialized extends InitializationState {}
