#!/usr/bin/env bash
set -euo pipefail

BLOCKSCOUT_DIR=${BLOCKSCOUT_DIR:-blockscout}

echo "→ Stopping & removing any running Blockscout containers…"
pushd "$BLOCKSCOUT_DIR/docker-compose" >/dev/null
  docker-compose down
popd >/dev/null

echo "→ Deleting persisted data volumes…"
for d in blockscout-db-data dets logs redis-data stats-db-data; do
  rm -rf "$BLOCKSCOUT_DIR/docker-compose/services/$d"
done

echo "✅ Cleaned up all Blockscout state"
