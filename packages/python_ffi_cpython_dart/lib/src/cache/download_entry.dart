part of python_ffi_cpython_dart;

final class _DownloadEntry {
  _DownloadEntry({required this.url, required this.sha256});

  final String url;
  final String sha256;

  String get filename => url.split("/").last;
}
