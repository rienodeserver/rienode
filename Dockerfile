# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables
ENV CODE_SERVER_VERSION=4.0.0
ENV PASSWORD=12321  # Change this to your desired password

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Download and install Code Server
RUN wget https://github.com/coder/code-server/releases/download/$CODE_SERVER_VERSION/code-server-$CODE_SERVER_VERSION-linux-amd64.tar.gz && \
    tar -xz -C /usr/local/bin --strip-components=1 code-server-$CODE_SERVER_VERSION-linux-amd64/* && \
    rm -rf code-server-$CODE_SERVER_VERSION-linux-amd64*

# Create a directory for the code server
WORKDIR /home/coder/project

# Expose the port that Code Server runs on
EXPOSE 8080

# Run Code Server
CMD ["code-server", "--auth", "password", "--password", "$PASSWORD", "--host", "0.0.0.0", "--port", "8080"]
