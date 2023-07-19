part of interface_generation;

extension LeftPadExtension on String {
  String leftPadLines(int count, {String pad = " "}) =>
      split("\n").map((String line) => "${pad * count}$line").join("\n");

  String indentLines({required int count, int indentation = 2}) =>
      leftPadLines(count, pad: " " * indentation);
}
