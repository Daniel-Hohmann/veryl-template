FROM ubuntu:24.04

# Install dependencies (git, curl, build essentials for Cargo)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    pkg-config \
    libssl-dev \
    ruby-full \
    ruby-dev \
    bundler \
    && rm -rf /var/lib/apt/lists/*

# Install Rust/Cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup default stable

# Install verylup via Cargo
RUN cargo install verylup

# Setup Veryl Toolchain (latest version)
RUN verylup setup

# Install rggen
RUN gem install rggen

# Install rggen-veryl plugin
RUN gem install rggen-veryl

# Set working directory
WORKDIR /workspace

# Default entrypoint: Start interactive shell with Veryl available
CMD ["/bin/bash"]

