import sys


def main(i_file: str, o_file: str):
    characters: list[int] = []
    with open(i_file, "r") as f:
        for c in f.read():
            characters.append(str(ord(c)))
    with open(o_file, "w") as f:
        output = f'import "dart:typed_data";\n\nfinal Uint8List kBytes = Uint8List.fromList(<int>[{", ".join(characters)}]);\n'
        f.write(output)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
