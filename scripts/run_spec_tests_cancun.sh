#!/usr/bin/env bash
set -eo pipefail

cd execution-spec-tests

# defaults — you can override by exporting before calling this script:
: "${UV:=uv}"
: "L2_RPC_URL=${LOCAL_L2_RPC_URL:-http://localhost:3050}"
: "${CHAIN_ID:=271}"
: "PRIVATE_KEY=${PRIVATE_KEY:-${PRIVATE_KEY}}"

echo "▶ Running execution-spec-tests (Cancun fork) against ${L2_RPC_URL}"

${UV} run execute remote \
  --fork Cancun \
  --rpc-endpoint "${L2_RPC_URL}" \
  --rpc-chain-id "${CHAIN_ID}" \
  -n auto \
  --rpc-seed-key "${PRIVATE_KEY}" \
  ./tests/cancun/
