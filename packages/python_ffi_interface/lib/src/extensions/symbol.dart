part of python_ffi_interface;

extension SymbolToNameExtension on Symbol {
  String get name =>
      RegExp(r'^Symbol\("(.*)"\)$').firstMatch(toString())?.group(1) ??
      toString();
}
