#!/usr/bin/env bash
set -euo pipefail

BLOCKSCOUT_DIR=${BLOCKSCOUT_DIR:-blockscout}

CHAIN_TYPE=${CHAIN_TYPE:-default}

echo "→ Ensuring Blockscout repo in '${BLOCKSCOUT_DIR}'…"
if [ ! -d "$BLOCKSCOUT_DIR" ]; then
  git clone https://github.com/Romsters/blockscout "$BLOCKSCOUT_DIR"
else
  echo "→ Repo already exists, pulling latest…"
  pushd "$BLOCKSCOUT_DIR" >/dev/null
    git fetch origin
    git reset --hard origin/master
  popd >/dev/null
fi

echo "→ Starting Blockscout (RPC at http://127.0.0.1:3050)…"
pushd "$BLOCKSCOUT_DIR/docker-compose" >/dev/null

export CHAIN_TYPE
export INDEXER_DISABLE_INTERNAL_TRANSACTIONS_FETCHER=true

# spin up all services, disable user-ops-indexer and run in detached mode
docker-compose up -d \
  --scale user-ops-indexer=0

popd >/dev/null

echo "✅ Blockscout should now be available at http://localhost"
