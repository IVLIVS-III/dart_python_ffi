import base64


def main():
    with open("python311.dll", "rb") as f_in:
        data = f_in.read()
        # convert to base64
        data = base64.b64encode(data)
        # convert to string
        data = data.decode("utf-8")
        # write to file
        with open("python311.txt", "w") as f_out:
            f_out.write(data)


if __name__ == "__main__":
    main()
