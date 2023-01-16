import "package:flutter/foundation.dart";
import "package:python_ffi_platform_interface/src/python_ffi_platform.dart";

abstract class PythonObjectPlatform<P extends PythonFfiPlatform<R>,
    R extends Object?> {
  PythonObjectPlatform(this.platform, this.reference);

  final P platform;
  final R reference;

  Object? toDartObject();

  T getAttributeRaw<T extends PythonObjectPlatform<P, R>>(String attributeName);
  T getAttribute<T extends Object?>(String attributeName);

  void setAttributeRaw<T extends PythonObjectPlatform<P, R>>(String attributeName, T value);
  void setAttribute<T extends Object?>(String attributeName, T value);

  /// Disposes the python object
  @mustCallSuper
  void dispose();

  /*
  @override
  @mustCallSuper
  dynamic noSuchMethod(Invocation invocation) {
    print("PythonObject.noSuchMethod: $invocation");
    return super.noSuchMethod(invocation);
  }
  */
}
