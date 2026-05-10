#!/bin/bash

set -e

root_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -sf "${root_path}/.tmux.conf" ~/.tmux.conf
