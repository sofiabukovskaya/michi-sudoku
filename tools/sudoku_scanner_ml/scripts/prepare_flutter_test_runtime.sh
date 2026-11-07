#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
  echo 'Usage: prepare_flutter_test_runtime.sh <Flutter SDK root> <Dart pub cache root>' >&2
  exit 64
fi

michi_flutter_sdk=$1
michi_pub_cache=$2
michi_source="$michi_pub_cache/hosted/pub.dev/tflite_flutter-0.12.1/macos/libtensorflowlite_c-mac.dylib"
michi_target_dir="$michi_flutter_sdk/bin/cache/artifacts/engine/resources"
michi_target="$michi_target_dir/libtensorflowlite_c-mac.dylib"

if [ ! -f "$michi_source" ]; then
  echo "Bundled macOS TFLite library not found: $michi_source" >&2
  exit 1
fi
mkdir -p "$michi_target_dir"
if [ ! -e "$michi_target" ]; then
  ln -s "$michi_source" "$michi_target"
fi
echo "$michi_target"
