part of python_ffi_cpython_dart;

final class _StdLibCache extends _Cache {
  _StdLibCache({required super.version, required super.cacheDir});

  @override
  _DownloadEntry? get _entry => _table[version];

  @override
  String get _loggerFileIdentifier => "Python stdlib";

  static final Map<String, _DownloadEntry> _table = <String, _DownloadEntry>{
    "3.11": _DownloadEntry(
      url:
          "https://github.com/IVLIVS-III/dart_python_ffi/raw/7223767779ed6bb789769fc494bfc284b1970c1b/packages/python_ffi_cpython_dart/stdlib/python3.11.zip",
      sha256:
          "a861da4d8d8227168302d7dffb4261bc1dc94ff68b66bcd0a8a574d7c2c2fa9a",
    ),
  };
}
