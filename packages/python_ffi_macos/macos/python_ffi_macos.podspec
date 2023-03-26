#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint python_ffi_macos.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'python_ffi_macos'
  s.version          = '0.0.1'
  s.summary          = 'The macOS implementation of python_ffi, a Python-FFI for Dart.'
  s.description      = <<-DESC
The macOS implementation of python_ffi, a Python-FFI for Dart.
                       DESC
  s.homepage         = 'https://github.com/IVLIVS-III/dart_python_ffi'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'

  s.vendored_libraries = 'python/dylib/libpython3.11.dylib'

  s.platform = :osx, '10.13'
end
