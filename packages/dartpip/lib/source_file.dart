part of dartpip;

class _SourceFile extends FileSystemEntity implements File {
  _SourceFile(String filePath) : _file = File(filePath);

  final File _file;

  @override
  File get absolute => _file.absolute;

  @override
  Future<File> copy(String newPath) => _file.copy(newPath);

  @override
  File copySync(String newPath) => _file.copySync(newPath);

  @override
  Future<File> create({bool recursive = false, bool exclusive = false}) =>
      _file.create(recursive: recursive, exclusive: exclusive);

  @override
  void createSync({bool recursive = false, bool exclusive = false}) =>
      _file.createSync(recursive: recursive, exclusive: exclusive);

  @override
  // ignore: avoid_slow_async_io
  Future<bool> exists() => _file.exists();

  @override
  bool existsSync() => _file.existsSync();

  @override
  Future<DateTime> lastAccessed() => _file.lastAccessed();

  @override
  DateTime lastAccessedSync() => _file.lastAccessedSync();

  @override
  // ignore: avoid_slow_async_io
  Future<DateTime> lastModified() => _file.lastModified();

  @override
  DateTime lastModifiedSync() => _file.lastModifiedSync();

  @override
  Future<int> length() => _file.length();

  @override
  int lengthSync() => _file.lengthSync();

  @override
  Future<RandomAccessFile> open({FileMode mode = FileMode.read}) =>
      _file.open(mode: mode);

  @override
  Stream<List<int>> openRead([int? start, int? end]) =>
      _file.openRead(start, end);

  @override
  RandomAccessFile openSync({FileMode mode = FileMode.read}) =>
      _file.openSync(mode: mode);

  @override
  IOSink openWrite({
    FileMode mode = FileMode.write,
    Encoding encoding = utf8,
  }) =>
      _file.openWrite(mode: mode, encoding: encoding);

  @override
  String get path => _file.path;

  @override
  Future<Uint8List> readAsBytes() => _file.readAsBytes();

  @override
  Uint8List readAsBytesSync() => _file.readAsBytesSync();

  @override
  Future<List<String>> readAsLines({Encoding encoding = utf8}) =>
      _file.readAsLines(encoding: encoding);

  @override
  List<String> readAsLinesSync({Encoding encoding = utf8}) =>
      _file.readAsLinesSync(encoding: encoding);

  @override
  Future<String> readAsString({Encoding encoding = utf8}) =>
      _file.readAsString(encoding: encoding);

  @override
  String readAsStringSync({Encoding encoding = utf8}) =>
      _file.readAsStringSync(encoding: encoding);

  @override
  Future<File> rename(String newPath) => _file.rename(newPath);

  @override
  File renameSync(String newPath) => _file.renameSync(newPath);

  @override
  Future<dynamic> setLastAccessed(DateTime time) => _file.setLastAccessed(time);

  @override
  void setLastAccessedSync(DateTime time) => _file.setLastAccessedSync(time);

  @override
  Future<dynamic> setLastModified(DateTime time) => _file.setLastModified(time);

  @override
  void setLastModifiedSync(DateTime time) => _file.setLastModifiedSync(time);

  @override
  Future<File> writeAsBytes(
    List<int> bytes, {
    FileMode mode = FileMode.write,
    bool flush = false,
  }) =>
      _file.writeAsBytes(bytes, mode: mode, flush: flush);

  @override
  void writeAsBytesSync(
    List<int> bytes, {
    FileMode mode = FileMode.write,
    bool flush = false,
  }) =>
      _file.writeAsBytesSync(bytes, mode: mode, flush: flush);

  @override
  Future<File> writeAsString(
    String contents, {
    FileMode mode = FileMode.write,
    Encoding encoding = utf8,
    bool flush = false,
  }) =>
      _file.writeAsString(
        contents,
        mode: mode,
        encoding: encoding,
        flush: flush,
      );

  @override
  void writeAsStringSync(
    String contents, {
    FileMode mode = FileMode.write,
    Encoding encoding = utf8,
    bool flush = false,
  }) =>
      _file.writeAsStringSync(
        contents,
        mode: mode,
        encoding: encoding,
        flush: flush,
      );

  void writeBytes(ByteData data) {
    if (!existsSync()) {
      createSync(recursive: true);
    }
    writeAsBytesSync(data.buffer.asUint8List());
  }

  void replace(RegExp regExp, String replacement) {
    if (!existsSync()) {
      createSync(recursive: true);
    }
    final String content = readAsStringSync();
    final RegExpMatch? match = regExp.firstMatch(content);
    String newContent = content;
    if (match == null) {
      newContent += "\n$replacement";
    } else {
      newContent = newContent.replaceRange(match.start, match.end, replacement);
    }
    writeAsStringSync(newContent);
  }

  void ensureHeader(String header) {
    final String content = readAsStringSync();
    if (!content.startsWith(header)) {
      writeAsStringSync("$header\n$content");
    }
  }

  void ensureFooter(String footer) {
    final String content = readAsStringSync();
    if (!content.endsWith(footer)) {
      writeAsStringSync("$content$footer");
    }
  }
}
