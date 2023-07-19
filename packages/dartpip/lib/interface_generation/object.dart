part of interface_generation;

final class ObjectInterface extends PythonObject
    with InterfaceImpl
    implements Interface {
  ObjectInterface.from(super.delegate)
      : _source = delegate,
        super.from();

  Object _source;

  @override
  Interface? collectChild(String childName) => _collectAttribute(childName);
}
