# Use the Ubuntu base image.
FROM ubuntu:latest

# Update package list and install required packages.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    bash \
    curl \
    file \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    python3.11

# Install Flutter.
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:${PATH}"

# Run Flutter doctor to verify installation and check for missing dependencies.
RUN flutter doctor

# Install melos (version < 3.0.0) for managing Dart packages.
RUN dart pub global activate melos 2.9.0
ENV PATH="$PATH:/root/.pub-cache/bin"

# Clone the Dart Python FFI repository.
RUN git clone https://github.com/IVLIVS-III/dart_python_ffi.git

# Set the working directory.
WORKDIR /dart_python_ffi

# Install dependencies.
RUN melos bootstrap && git restore **/*.g.dart

# Set the default command.
CMD ["bash"]
