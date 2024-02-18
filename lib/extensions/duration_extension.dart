extension DurationExtension on Duration {
  String stringify() {
    List<String> splitDuration = toString().split(":");
    final String hours = splitDuration[0].padLeft(2, "0");
    final String minutes = splitDuration[1];
    final List<String> splitSeconds = splitDuration[2].split(".");
    final String seconds = splitSeconds[0];
    final String milliseconds = splitSeconds[1].substring(0, 3);

    return "$hours:$minutes:$seconds:$milliseconds";
  }
}
