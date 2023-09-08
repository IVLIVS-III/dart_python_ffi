extension DurationExtension on Object? {
  Duration get asDuration {
    final Object? value = this;
    if (value == null) {
      return Duration.zero;
    }
    if (value is int) {
      return Duration(seconds: value);
    }
    if (value is double) {
      return Duration(microseconds: (value * 1000000).toInt());
    }
    throw ArgumentError.value(
      value,
      "value",
      "Conversion to Duration only supported for int and double.",
    );
  }
}
