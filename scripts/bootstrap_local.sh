#!/usr/bin/env bash
set -eEuo pipefail

### ─── Configuration (tweak as needed) ─────────────────────────── ###
: "${REPO_URL:=git@github.com:matter-labs/zksync-era.git}"
: "${DIR:=zksync-era}"
: "${BRANCH:=zksync-os-integration}"

: "${L1_RPC_URL:=http://localhost:8545}"
: "${DB_URL:=postgres://postgres:notsecurepassword@localhost:5432}"
: "${DB_NAME:=zksync_server_localhost_era}"
### ─────────────────────────────────────────────────────────────── ###

cleanup() {
  echo "❌ Error encountered. Cleaning up zkstack containers…"
  if [ -d "$DIR" ] && [ -f "$DIR/zkstack.toml" ]; then
    pushd "$DIR" >/dev/null
    zkstack dev clean all || echo "⚠️  zkstack dev clean failed"
    popd  >/dev/null
  fi
}
trap cleanup ERR

### 1) Clone or validate the repo ###
if [ -d "$DIR" ]; then
  if [ -d "$DIR/.git" ]; then
    echo "→ Repo '$DIR' exists, fetching latest…"
    pushd "$DIR" >/dev/null
      git fetch origin
    popd >/dev/null
  else
    echo "❌ Directory '$DIR' exists but is not a git repository."
    exit 1
  fi
else
  echo "→ Cloning '$REPO_URL' into '$DIR'…"
  git clone "$REPO_URL" "$DIR"
fi

### 2) Checkout branch ###
pushd "$DIR" >/dev/null
  echo "→ Checking out branch '$BRANCH'…"
  git checkout "$BRANCH"
  git pull --ff-only origin "$BRANCH"

  ### 3) zkStack spin-up ###
  echo "→ Running zkstackup…"
  zkstackup --local

  echo "→ Launching containers…"
  zkstack containers -o false

  echo "→ Initializing ecosystem…"
  zkstack ecosystem init \
    --deploy-ecosystem \
    --deploy-paymaster \
    --deploy-erc20 \
    --l1-rpc-url="$L1_RPC_URL" \
    --server-db-url="$DB_URL" \
    --server-db-name="$DB_NAME" \
    --ignore-prerequisites \
    --verbose \
    --observability=false

  echo "→ Starting zkstack server…"
  zkstack server \
    --ignore-prerequisites \
    --chain era 
popd >/dev/null

echo "✅ All done! Your local environment is up."
