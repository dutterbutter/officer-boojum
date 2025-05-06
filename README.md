**Updating README**

The user needs the README updated with new sections reflecting recent changes, like adding options for spinning up the Blockscout explorer, additional make commands, and updates to .env. I'll include sections on:

* New .env variables like LOCAL\_L2\_RPC\_URL, LOCAL\_L1\_RPC\_URL, BOOJUM\_NET\_RPC\_URL, BOOJUM\_NET\_RICH\_ACCOUNT, ENVIRONMENT. I'll note their usage.
* New make targets: clean-local, verify-reverting, blockscout-up, blockscout-down, and blockscout-reset.
  I’ll also update the Quick Start and examples for .env. This should cover all the necessary details in proper markdown.


Thought for 4 seconds


Here’s an updated **README.md** that reflects:

* the new `.env` layout and `ENVIRONMENT` switch
* the `clean-local` and `verify-reverting` targets
* our Blockscout Explorer helpers (`blockscout-up`, `blockscout-down`, `blockscout-reset`)

````markdown
# officer-boojum

Minimal test stand for BoojumOS / zkSync-Era.

---

## Quick start

```bash
# 1) Clone & spin up your complete local BoojumOS + zkSync-Era stack
make bootstrap

# 2) (Optional) Clean up any existing local state
make clean-local

# 3) Fund your dev L2 account with test ETH (10 Ξ by default)
make fund
````

---

## Environment

Copy the example and fill in your keys / URLs:

```bash
cp .env-example .env
```

```dotenv
# Your deployer private key
PRIVATE_KEY=0xabc…dead

# Local stack RPC endpoints
LOCAL_L2_RPC_URL=http://localhost:3050
LOCAL_L1_RPC_URL=http://localhost:8545

# Hosted BoojumNet (if you want to target the remote network)
BOOJUM_NET_RPC_URL=https://boojum.example.com
BOOJUM_NET_RICH_ACCOUNT=0xyourRichAccount…

# Choose which network to target in `make` commands:
#   ENVIRONMENT=local   → uses LOCAL_* URLs + PRIVATE_KEY
#   ENVIRONMENT=boojum  → uses BOOJUM_NET_* URLs + RICH_ACCOUNT
ENVIRONMENT=local

# (Optional) if you prefer an unlocked account over raw key
# ACCOUNT=test-wallet
```

## Makefile targets

Run `make help` to see them all, but here are the highlights:

### 🌱 Bootstrap & Cleanup

| Target             | Description                                      |
| ------------------ | ------------------------------------------------ |
| `make bootstrap`   | Spin up a full local BoojumOS + zkSync-Era stack |
| `make clean-local` | Tear‐down & wipedown all local bootstrap state   |
| `make fund`        | Fund your L2 address via the BridgeHub cheatcode |

### 🤝 Deployment scripts

| Target                              | What it does                          |
| ----------------------------------- | ------------------------------------- |
| `make deploy-hello-world`           | Bare deploy, no constructor args      |
| `make deploy-with-constructor-args` | Deploy + constructor args & ETH       |
| `make link-library-and-deploy`      | Deploy a runtime library (MathLib)    |
| `make deploy-library-user`          | Deploy a consumer linked to MathLib   |
| `make deploy-via-create2`           | Deterministic `CREATE2` deployment    |
| `make deploy-and-interact`          | Deploy + immediately interact         |
| `make deploy-reverting-constructor` | Test revert‐in‐ctor handling          |
| `make verify-reverting`             | Run both reverting scripts (no halt)  |
| `make test-system-predeploy`        | Hit Boojum predeploy via P256 address |
| `make deploy-with-gas-overrides`    | Custom gas & price overrides          |
| `make deploy-dependent-contracts`   | Multi‐contract wiring                 |
| `make deploy-dynamic-array`         | Deploy with large calldata arrays     |
| `make deploy-emit-event`            | Emit event in constructor             |
| `make deploy-selfdestruct`          | Self‐destruct edge‐case               |
| `make deploy-delegatecall`          | Delegate‐call initializer             |
| `make deploy-upgradeable-proxy`     | OpenZeppelin proxy pattern            |
| `make deploy-max-gas-constructor`   | Near‐block‐limit ctor                 |
| `make deploy-receive-ether`         | `receive()` & fallback logic          |
| `make deploy-large-bytecode`        | > 24 KB runtime size                  |
| `make deploy-mapping-init`          | Nested mapping initialization         |
| `make deploy-revert-reason`         | Custom‐error decode                   |
| `make deploy-inline-assembly`       | Yul‐only constructor                  |
| **`make all`**                      | Run every deploy target above         |

### 🔍 Blockscout Explorer

You can now spin up a local Blockscout instance against your BoojumOS RPC:

```bash
# bring everything up (uses ./blockscout folder by default)
make blockscout-up

# stop & wipe your Blockscout containers + volumes
make blockscout-down

# just wipe volumes (keep containers & docker-compose)
make blockscout-reset
```

Once `blockscout-up` completes, your explorer UI & API will be live at:

```bash
http://localhost        ← frontend
http://localhost/api    ← REST endpoints
http://localhost:8080   ← stats-server
http://localhost:8081   ← visualizer
```

## `make help`

You can always run:

```bash
make help
```
