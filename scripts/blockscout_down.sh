# scripts/blockscout-down.sh
#!/usr/bin/env bash
set -euo pipefail

# Adjust this path if you cloned Blockscout somewhere else
BLOCKSCOUT_DIR="${BLOCKSCOUT_DIR:-./blockscout}/docker-compose"

echo "⏬ Stopping Blockscout services…"
pushd "$BLOCKSCOUT_DIR" >/dev/null
docker-compose down

echo "🗑️  Removing volumes & state directories…"
rm -rf services/blockscout-db-data \
       services/dets \
       services/logs \
       services/redis-data \
       services/stats-db-data

popd >/dev/null

echo "✅ Blockscout fully stopped and data wiped."
