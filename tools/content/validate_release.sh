#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$repo_root"
source="${1:?Pass a source release JSON path}"
artifact="${2:?Pass an output artifact path}"
dart --packages=.dart_tool/package_config.json \
  apps/mobile/tool/validate_content_release.dart "$source" "$artifact"
