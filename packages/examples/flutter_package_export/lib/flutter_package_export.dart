library flutter_package_export;

import "package:flutter/material.dart";
import "package:flutter_package_export/python_modules/basic_adder.g.dart";
import "package:python_ffi/python_ffi.dart";

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PythonFfi.instance.initialize(package: "flutter_package_export");
}

num add(num x, num y) => basic_adder.import().add(x: x, y: y)! as num;
