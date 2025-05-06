#!/usr/bin/env bash
set -euo pipefail

# change this if your repo folder is named differently
ZK_DIR=${1:-./zksync-era-private}

# assumes port 3050 is being used
echo "🔍 Checking for any process listening on TCP port 3050…"
if lsof -ti TCP:3050 >/dev/null; then
  echo "💥 Killing process on port 3050"
  lsof -ti TCP:3050 | xargs --no-run-if-empty kill -9
else
  echo "✅ No process on port 3050"
fi

if [ -d "$ZK_DIR" ]; then
  echo "🧹 Cleaning zkstack in $ZK_DIR…"
  pushd "$ZK_DIR" >/dev/null
    zkstack dev clean all
  popd >/dev/null
  echo "✅ zkstack cleaned"
else
  echo "❌ Directory '$ZK_DIR' not found; skip zkstack clean" >&2
  exit 1
fi
