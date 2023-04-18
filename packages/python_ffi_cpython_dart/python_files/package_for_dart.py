import base64


def main():
    input_files = ["python311.dll", "libpython3.11.so"]
    for file in input_files:
        filename = ".".join(file.split(".")[:-1])
        with open(file, "rb") as f_in:
            data = f_in.read()
            # convert to base64
            data = base64.b64encode(data)
            # convert to string
            data = data.decode("utf-8")
            # write to file
            with open(f"{filename}.txt", "w") as f_out:
                f_out.write(data)


if __name__ == "__main__":
    main()
