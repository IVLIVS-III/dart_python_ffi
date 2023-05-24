#include <stdio.h>
#include <stddef.h>
#include <dlfcn.h>

typedef struct {
    int utf8_mode;
    int configure_locale;
    int coerce_c_locale;
} PyPreConfig;

typedef struct {} PyStatus;

typedef struct {
    wchar_t* filesystem_encoding;
    wchar_t* filesystem_errors;
    wchar_t* home;
    int verbose;
} PyConfig;

int main() {
    void* handle = dlopen("libpython3.11.so", RTLD_LAZY);
    if (handle == NULL) {
        printf("Failed to load the library: %s\n", dlerror());
        return 1;
    }

    /*
    typedef void (*PyPreConfig_InitIsolatedConfigFunc)(PyPreConfig *);
    PyPreConfig_InitIsolatedConfigFunc PyPreConfig_InitIsolatedConfig = (PyPreConfig_InitIsolatedConfigFunc)dlsym(handle, "PyPreConfig_InitIsolatedConfig");

    typedef PyStatus (*Py_PreInitializeFunc)(PyPreConfig *);
    Py_PreInitializeFunc Py_PreInitialize = (Py_PreInitializeFunc)dlsym(handle, "Py_PreInitialize");

    typedef int (*PyStatus_ExceptionFunc)(PyStatus);
    PyStatus_ExceptionFunc PyStatus_Exception = (PyStatus_ExceptionFunc)dlsym(handle, "PyStatus_Exception");

    typedef void (*Py_ExitStatusExceptionFunc)(PyStatus);
    Py_ExitStatusExceptionFunc Py_ExitStatusException = (Py_ExitStatusExceptionFunc)dlsym(handle, "Py_ExitStatusException");

    typedef void (*PyConfig_InitIsolatedConfigFunc)(PyConfig *);
    PyConfig_InitIsolatedConfigFunc PyConfig_InitIsolatedConfig = (PyConfig_InitIsolatedConfigFunc)dlsym(handle, "PyConfig_InitIsolatedConfig");

    typedef PyStatus (*PyConfig_SetStringFunc)(PyConfig *, wchar_t **, wchar_t *);
    PyConfig_SetStringFunc PyConfig_SetString = (PyConfig_SetStringFunc)dlsym(handle, "PyConfig_SetString");

    typedef PyStatus (*Py_InitializeFromConfigFunc)(PyConfig *);
    Py_InitializeFromConfigFunc Py_InitializeFromConfig = (Py_InitializeFromConfigFunc)dlsym(handle, "Py_InitializeFromConfig");

    PyPreConfig preConfig;
    PyPreConfig_InitIsolatedConfig(&preConfig);
    preConfig.utf8_mode = 1;
    preConfig.configure_locale = 1;
    preConfig.coerce_c_locale = 2;

    PyStatus status;
    status = Py_PreInitialize(&preConfig);
    if (PyStatus_Exception(status)) {
        Py_ExitStatusException(status);
    }

    PyConfig config;
    PyConfig_InitIsolatedConfig(&config);
    config.verbose = 1;

    status = PyConfig_SetString(&config, &config.filesystem_encoding, L"utf-8");
    if (PyStatus_Exception(status)) {
        Py_ExitStatusException(status);
    }

    status = PyConfig_SetString(&config, &config.filesystem_errors, L"surrogateescape");
    if (PyStatus_Exception(status)) {
        Py_ExitStatusException(status);
    }

    status = PyConfig_SetString(&config, &config.home, L"/tmp/python_ffi");
    if (PyStatus_Exception(status)) {
        Py_ExitStatusException(status);
    }

    status = Py_InitializeFromConfig(&config);
    if (PyStatus_Exception(status)) {
        Py_ExitStatusException(status);
    }
    */

    /**/
    // Function pointer for Py_Initialize
    typedef void (*Py_InitializeFunc)(void);

    // Get the address of Py_Initialize
    Py_InitializeFunc initialize = (Py_InitializeFunc)dlsym(handle, "Py_Initialize");
    if (initialize == NULL) {
        printf("Failed to get symbol address: %s\n", dlerror());
        dlclose(handle);
        return 1;
    }

    // Call Py_Initialize to initialize the Python runtime
    initialize();
    /**/

    // Print Python version
    typedef char *(*Py_GetVersionFunc)(void);
    Py_GetVersionFunc getVersion = (Py_GetVersionFunc)dlsym(handle, "Py_GetVersion");
    printf("Python version: %s\n", getVersion());

    // Close the library
    dlclose(handle);
    return 0;
}
