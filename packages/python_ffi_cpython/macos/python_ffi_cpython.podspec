#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint python_ffi_cpython.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'python_ffi_cpython'
  s.version          = '0.0.3'
  s.summary          = 'The macOS and Windows implementation of python_ffi, a Python-FFI for Dart.'
  s.description      = <<-DESC
The macOS and Windows implementation of python_ffi, a Python-FFI for Dart.
                       DESC
  s.homepage         = 'https://github.com/IVLIVS-III/dart_python_ffi'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Julius Bredemeyer' => '48645716+IVLIVS-III@users.noreply.github.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'

  s.vendored_libraries = 'python/dylib/libpython3.11.dylib'

  s.platform = :osx, '10.13'
end
