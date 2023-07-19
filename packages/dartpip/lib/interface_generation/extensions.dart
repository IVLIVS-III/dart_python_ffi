part of interface_generation;

extension LeftPadExtension on String {
  String leftPadLines(
    int count, {
    String pad = " ",
    bool trimLines = false,
  }) =>
      split("\n")
          .map(
            (String line) => "${pad * count}${trimLines ? line.trim() : line}",
          )
          .join("\n");

  String indentLines({required int count, int indentation = 2}) =>
      leftPadLines(count, pad: " " * indentation);
}
