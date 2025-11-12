#!/usr/bin/env bash
set -euo pipefail

# update-version.sh
# Update version in pyproject.toml
# Usage: update-version.sh <version>

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version>" >&2
  exit 1
fi

VERSION="$1"

# Remove 'v' prefix for Python versioning
PYTHON_VERSION=${VERSION#v}

if [ -f "pyproject.toml" ]; then
  sed -i "s/version = \".*\"/version = \"$PYTHON_VERSION\"/" pyproject.toml
  echo "Updated pyproject.toml version to $PYTHON_VERSION"
else
  echo "Error: pyproject.toml not found" >&2
  exit 1
fi
