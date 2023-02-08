abstract class BaseInterface {
  /// Constructs a PlatformInterface, for use only in constructors of abstract
  /// derived classes.
  ///
  /// @param token The same, non-`const` `Object` that will be passed to `verify`.
  BaseInterface({required Object token}) {
    _instanceTokens[this] = token;
  }

  /// Expando mapping instances of PlatformInterface to their associated tokens.
  /// The reason this is not simply a private field of type `Object?` is because
  /// as of the implementation of field promotion in Dart
  /// (https://github.com/dart-lang/language/issues/2020), it is a runtime error
  /// to invoke a private member that is mocked in another library.  The expando
  /// approach prevents [_verify] from triggering this runtime exception when
  /// encountering an implementation that uses `implements` rather than
  /// `extends`.  This in turn allows [_verify] to throw an [AssertionError] (as
  /// documented).
  static final Expando<Object> _instanceTokens = Expando<Object>();

  /// Ensures that the platform instance was constructed with a non-`const` token
  /// that matches the provided token and throws [AssertionError] if not.
  ///
  /// This is used to ensure that implementers are using `extends` rather than
  /// `implements`.
  static void verify(BaseInterface instance, Object token) {
    if (identical(_instanceTokens[instance], const Object())) {
      throw AssertionError("`const Object()` cannot be used as the token.");
    }
    if (!identical(token, _instanceTokens[instance])) {
      throw AssertionError(
        "Platform interfaces must not be implemented with `implements`",
      );
    }
  }
}
