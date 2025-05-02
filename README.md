# officer‑boojum

Minimal test stand for boojumOS.

## Quick start

```bash
# clone + spin up the complete local stack
make bootstrap

# fund your dev L2 account with test ETH (10 Ξ by default)
make fund
````

> **Note:** Update `scripts/fund_rich.sh` with correct Bridgehub address.

`.env` - see .env-example for reference:

```dotenv
PRIVATE_KEY=0xabc…dead
BOOJUM_LOCAL_RPC_URL=http://localhost:3050 # your local L2 RPC

# optional if you prefer an unlocked account over a raw key
#ACCOUNT=test-wallet
```

## Deployment scripts

| make target                         | what it covers               |
| ----------------------------------- | ---------------------------- |
| `make deploy-hello-world`           | bare deploy, no constructor  |
| `make deploy-with-constructor-args` | constructor args + ETH value |
| `make link-library-and-deploy`      | runtime library linking      |
| `make deploy-library-user`          | linked consumer (03 b)       |
| `make deploy-via-create2`           | deterministic `CREATE2`      |
| `make deploy-and-interact`          | deploy + immediate calls     |
| `make deploy-reverting-constructor` | revert handling              |
| `make test-system-predeploy`        | call Boojum predeploy (P256) |
| `make deploy-with-gas-overrides`    | custom gas/price             |
| `make deploy-dependent-contracts`   | multi‑contract wiring        |
| `make deploy-dynamic-array`         | big calldata array           |
| `make deploy-emit-event`            | event in constructor         |
| `make deploy-selfdestruct`          | `selfdestruct` edge‑case     |
| `make deploy-delegatecall`          | delegate‑initialiser         |
| `make deploy-upgradeable-proxy`     | OZ proxy pattern             |
| `make deploy-max-gas-constructor`   | near‑block‑limit constructor |
| `make deploy-receive-ether`         | `receive()` & fallback       |
| `make deploy-large-bytecode`        | 24 KB+ runtime size          |
| `make deploy-mapping-init`          | nested mapping writes        |
| `make deploy-revert-reason`         | custom‑error decode          |
| `make deploy-inline-assembly`       | Yul‑only constructor         |
| **`make all`**                      | runs every target above      |

All scripts live in `script/*.s.sol` and broadcast using the shared `$(FLAGS)`.
