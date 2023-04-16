# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(python_ffi_cpython_library VERSION 0.0.3 LANGUAGES C)

add_library(python_ffi_cpython SHARED
  "python_ffi_cpython.c"
)

set_target_properties(python_ffi_cpython PROPERTIES
  PUBLIC_HEADER python_ffi_cpython.h
  OUTPUT_NAME "python_ffi_cpython"
)

target_compile_definitions(python_ffi_cpython PUBLIC DART_SHARED_LIB)
