part of python_ffi_cpython_dart;

final class _DylibCache extends _Cache {
  _DylibCache({required super.version, required super.cacheDir});

  @override
  _DownloadEntry? get _entry {
    final Map<String, _DownloadEntry>? versionEntry = _table[version];
    if (versionEntry == null) {
      return null;
    }
    return versionEntry[Platform.operatingSystem];
  }

  @override
  String get _loggerFileIdentifier => "Python runtime";

  static final Map<String, Map<String, _DownloadEntry>> _table =
      <String, Map<String, _DownloadEntry>>{
    "3.11.3": <String, _DownloadEntry>{
      "macos": _DownloadEntry(
        url:
            "https://github.com/IVLIVS-III/dart_python_ffi/raw/f24776a00dd76b1b171c7671c555ee6678b81046/packages/python_ffi_cpython_dart/macos/libpython3.11.dylib",
        sha256:
            "49c2beedbff74d5c7ab1d63b2ab74f3264602fe5ddd85f7f5900b6676c02ad7f",
      ),
      /*
      "linux": _DownloadEntry(
        url:
            "https://github.com/IVLIVS-III/dart_python_ffi/raw/f24776a00dd76b1b171c7671c555ee6678b81046/packages/python_ffi_cpython_dart/linux/libpython3.11.so",
        sha256:
            "6ac68fdf70bdfd721231a305321856f692c7e28f647664f1cc4b3b71b28da31e",
      ),
      "windows": _DownloadEntry(
        url: "https://github.com/IVLIVS-III/dart_python_ffi/raw/2907413c709759ba3d1c90c848b0ba9e0a321b35/packages/python_ffi_cpython_dart/windows/python311.dll",
        sha256:
            "7701424c5c3f3990f6e442117d2b7b9a9eabed0818cf5402c33cd84eb5327a17",
      ),
      */
    },
  };
}
