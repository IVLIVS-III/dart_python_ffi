part of interface_generation;

final class ClassInterface extends PythonClass
    with InterfaceImpl
    implements Interface {
  ClassInterface.from(super.delegate)
      : _source = delegate,
        super.from();

  Object _source;

  @override
  void collectChild(String childName) => _collectAttribute(childName);
}
