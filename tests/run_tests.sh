#!/bin/bash

# Test runner for dev-environment-setup
# Usage: ./tests/run_tests.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

PASSED=0
FAILED=0

pass() {
    echo "✓ PASS: $1"
    ((PASSED++)) || true
}

fail() {
    echo "✗ FAIL: $1"
    ((FAILED++)) || true
}

# Test 1: All .sh files have valid bash syntax
test_bash_syntax() {
    echo "=== Testing bash syntax ==="
    local files
    files=$(find "$ROOT_DIR" -name "*.sh" -type f -not -path "*/devbox/.devbox/*" 2>/dev/null)
    for file in $files; do
        if bash -n "$file" 2>/dev/null; then
            pass "Syntax OK: $file"
        else
            fail "Syntax error: $file"
        fi
    done
}

# Test 2: All source.sh files are readable
test_source_files() {
    echo "=== Testing source.sh files ==="
    local files
    files=$(find "$ROOT_DIR" -mindepth 2 -name "source.sh" -type f 2>/dev/null)
    for file in $files; do
        if [[ -r "$file" ]]; then
            pass "Readable: $file"
        else
            fail "Not readable: $file"
        fi
    done
}

# Test 3: All install.sh files are executable
test_install_files() {
    echo "=== Testing install.sh files ==="
    local files
    files=$(find "$ROOT_DIR" -mindepth 2 -name "install.sh" -type f -not -path "*/devbox/.devbox/*" 2>/dev/null)
    for file in $files; do
        if [[ -x "$file" ]]; then
            pass "Executable: $file"
        else
            fail "Not executable: $file"
        fi
    done
}

# Test 4: devbox.json is valid JSON
test_devbox_json() {
    echo "=== Testing devbox.json ==="
    local json_file="$ROOT_DIR/devbox/devbox.json"
    if python3 -c "import json; json.load(open('$json_file'))" 2>/dev/null; then
        pass "Valid JSON: $json_file"
    else
        fail "Invalid JSON: $json_file"
    fi
}

# Test 5: Required files exist
test_required_files() {
    echo "=== Testing required files ==="
    local required_files=(
        "$ROOT_DIR/install.sh"
        "$ROOT_DIR/bashrc.sh"
        "$ROOT_DIR/README.md"
        "$ROOT_DIR/devbox/devbox.json"
    )
    for file in "${required_files[@]}"; do
        if [[ -f "$file" ]]; then
            pass "Exists: $(basename "$file")"
        else
            fail "Missing: $file"
        fi
    done
}

# Test 6: Symlink targets exist
test_symlink_targets() {
    echo "=== Testing symlink targets ==="
    if [[ -f "$ROOT_DIR/tmux/.tmux.conf" ]]; then
        pass "tmux/.tmux.conf exists"
    else
        fail "tmux/.tmux.conf missing"
    fi

    if [[ -f "$ROOT_DIR/devbox/devbox.json" ]]; then
        pass "devbox/devbox.json exists"
    else
        fail "devbox/devbox.json missing"
    fi

    if [[ -f "$ROOT_DIR/devbox/devbox.lock" ]]; then
        pass "devbox/devbox.lock exists"
    else
        fail "devbox/devbox.lock missing"
    fi
}

# Test 7: No hardcoded absolute home paths in scripts
test_no_hardcoded_paths() {
    echo "=== Testing for hardcoded paths ==="
    local files
    files=$(find "$ROOT_DIR" -name "*.sh" -type f -not -path "*/devbox/.devbox/*" -not -path "*/tests/*" 2>/dev/null)
    for file in $files; do
        if grep -qE '/home/[^/]+/' "$file" 2>/dev/null; then
            fail "Hardcoded path in: $file"
        else
            pass "No hardcoded paths in: $(basename "$file")"
        fi
    done
}

# Run all tests
main() {
    echo "Running tests for dev-environment-setup..."
    echo ""

    test_bash_syntax
    echo ""
    test_source_files
    echo ""
    test_install_files
    echo ""
    test_devbox_json
    echo ""
    test_required_files
    echo ""
    test_symlink_targets
    echo ""
    test_no_hardcoded_paths

    echo ""
    echo "================================"
    echo "Results: $PASSED passed, $FAILED failed"
    echo "================================"

    if [[ $FAILED -gt 0 ]]; then
        exit 1
    fi
}

main "$@"