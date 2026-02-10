FROM ubuntu:24.04

# Installiere Abhängigkeiten (git, curl, build essentials für Cargo)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Installiere Rust/Cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup default stable

# Installiere verylup via Cargo
RUN cargo install verylup

# Setup Veryl Toolchain (latest Version)
RUN verylup setup

# Setze Arbeitsverzeichnis
WORKDIR /workspace

# Standard-Entrypoint: Starte interaktive Shell mit Veryl verfügbar
CMD ["/bin/bash"]

