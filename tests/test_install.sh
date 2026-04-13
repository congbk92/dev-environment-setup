#!/bin/bash

# Integration test that runs inside a container to verify the full setup
# Usage: ./tests/test_install.sh [container_runtime]
# container_runtime: docker (default) or podman

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
CONTAINER_RUNTIME="${1:-docker}"
IMAGE_NAME="dev-env-test:latest"

echo "=== Building test container ==="
$CONTAINER_RUNTIME build -t "$IMAGE_NAME" -f - "$ROOT_DIR" << 'EOF'
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/root

RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Nix
RUN curl --proto '=https' --tlsv1.2 -sSf https://nixos.org/nix/install | sh -s -- --no-daemon

# Install devbox
RUN curl -fsSL https://get.jetify.com/devbox | bash

ENV PATH="/root/.local/bin:/nix/var/nix/profiles/default/bin:${PATH}"

WORKDIR /setup
COPY . .

RUN chmod +x install.sh
EOF

echo ""
echo "=== Running installation test ==="
$CONTAINER_RUNTIME run --rm "$IMAGE_NAME" bash -c '
set -e
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
export PATH="$HOME/.local/bin:$PATH"

echo "--- Running install.sh ---"
./install.sh

echo ""
echo "--- Verifying symlinks ---"
test -L ~/.local/share/devbox/global/default/devbox.json && echo "✓ devbox.json symlink OK"
test -L ~/.local/share/devbox/global/default/devbox.lock && echo "✓ devbox.lock symlink OK"

echo ""
echo "--- Verifying packages ---"
devbox global list

echo ""
echo "=== Installation test PASSED ==="
'

echo ""
echo "=== Cleaning up ==="
$CONTAINER_RUNTIME rmi "$IMAGE_NAME" 2>/dev/null || true

echo "Test completed successfully!"