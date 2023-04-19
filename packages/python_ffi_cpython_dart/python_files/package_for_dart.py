import base64


def main():
    input_files = {
        "python3.11.dll": lambda x: f"""
part of python_ffi_cpython_dart;

const String _kPython311Dll = \"\"\"{x}\"\"\";

""",
        "libpython3.11.so": lambda x: f"""
part of python_ffi_cpython_dart;

const String _kLibPython311SO = \"\"\"{x}\"\"\";

""",
    }
    for file, transform in input_files.items():
        with open(file, "rb") as f_in:
            data = f_in.read()
            # convert to base64
            data = base64.b64encode(data)
            # convert to string
            data = data.decode("utf-8")
            # write to file
            with open(f"{file}.g.dart", "w") as f_out:
                f_out.write(transform(data))


if __name__ == "__main__":
    main()
