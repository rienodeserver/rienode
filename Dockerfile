# Use a Python image as the base
FROM python:3.10-slim

# Set environment variables
ENV CODE_SERVER_VERSION=4.0.0
ENV PASSWORD=your_password_here  # Change this to your desired password

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Download and install Code Server
RUN curl -fsSL https://github.com/coder/code-server/releases/download/$CODE_SERVER_VERSION/code-server-$CODE_SERVER_VERSION-linux-amd64.tar.gz | \
    tar -xz -C /usr/local/bin --strip-components=1

# Create a directory for the code server
WORKDIR /home/coder/project

# Copy the requirements file and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Expose the port that Code Server runs on
EXPOSE 8080

# Command to run Code Server
CMD ["code-server", "--auth", "password", "--password", "$PASSWORD", "--host", "0.0.0.0", "--port", "8080"]
