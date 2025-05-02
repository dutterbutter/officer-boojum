#!/usr/bin/env bash
set -euo pipefail

export $(grep -v '^#' .env | xargs)

# ─── Configurable variables ─────────────
RPC_URL=${L1_RPC_URL:-http://localhost:8545}

FROM=${FROM:-0x36615Cf349d7F6344891B1e7CA7C72883F5dc049}
PRIVATE_KEY=${PRIVATE_KEY_2:-${PRIVATE_KEY_2}}

# Call `zks_getBridgehubContract` for address
BRIDGE_HUB=${BRIDGE_HUB:-0x18867ee275511faab6f4521523b2b9d3f1a701e2}
CHAIN_ID=${CHAIN_ID:-271}

# 10 ETH on L1 → L2
DEPOSIT_WEI=${DEPOSIT_WEI:-10000000000000000000}

# L2 tx parameters
L2_VALUE=${L2_VALUE:-0}
L2_CALLDATA=${L2_CALLDATA:-0x00}
L2_GAS_LIMIT=${L2_GAS_LIMIT:-1000000}
PUBDATA_LIMIT=${PUBDATA_LIMIT:-800}

# Factory-deps - default to one dummy 32-byte blob
FACTORY_DEP=${FACTORY_DEP:-${PRIVATE_KEY_2}}
FACTORY_DEPS="[${FACTORY_DEP}]"

# L1 gas settings
GAS_LIMIT=${GAS_LIMIT:-10000000}
GAS_PRICE=${GAS_PRICE:-50000000}      # in wei
# ────────────────────────────────────────────────────────────────────

echo "→ Depositing $(bc -l <<<"scale=4; $DEPOSIT_WEI/1e18") ETH from $FROM to L2 (chain $CHAIN_ID)…"

# (chainId, mintValue, to, l2Value, l2Calldata, l2GasLimit, l2GasPerPubdata, factoryDeps, refundRecipient)
ARGS="($CHAIN_ID,$DEPOSIT_WEI,$FROM,$L2_VALUE,$L2_CALLDATA,$L2_GAS_LIMIT,$PUBDATA_LIMIT,$FACTORY_DEPS,$FROM)"

cast send \
  --rpc-url     "$RPC_URL" \
  --from        "$FROM" \
  --private-key "$PRIVATE_KEY" \
  "$BRIDGE_HUB" \
  'requestL2TransactionDirect((uint256,uint256,address,uint256,bytes,uint256,uint256,bytes[],address))' \
  "$ARGS" \
  --gas-limit "$GAS_LIMIT" \
  --gas-price "$GAS_PRICE" \
  --value     "$DEPOSIT_WEI"

echo ""
echo "✅ Tx submitted, check your L2 balance with cast balance <address> --rpc-url <L2-URL>."
