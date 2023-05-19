import "package:python_ffi/python_ffi.dart";

final class FJModule extends PythonModule {
  FJModule.from(super.pythonModule) : super.from();

  static FJModule import() => PythonModule.import(
        "fj",
        FJModule.from,
      );

  List<String> fjRun(
    String sourceCodeTxt, {
    bool withConstructor = false,
    bool onlyTypecheck = false,
  }) =>
      List<String>.from(
        getFunction("fj_run").call(
          <Object?>[sourceCodeTxt],
          kwargs: <String, bool>{
            "with_constructor": withConstructor,
            "only_typecheck": onlyTypecheck,
          },
        ),
      );
}
