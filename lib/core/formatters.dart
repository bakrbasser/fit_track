// ignore: non_constant_identifier_names
String HH_MM(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));

  return '$hours:$minutes';
}

// ignore: non_constant_identifier_names
String MM_SS(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return '$minutes:$seconds';
}
