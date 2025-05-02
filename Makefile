# ─────────────────────────────────────────────────────────────────────────────
# Load .env (if present) so PRIVATE_KEY, BOOJUM_LOCAL_RPC_URL, ACCOUNT, etc.
# ─────────────────────────────────────────────────────────────────────────────
-include .env

# Required variables
PRIVATE_KEY ?= $(error PRIVATE_KEY is not set - add it to .env or export in shell)
BOOJUM_LOCAL_RPC_URL ?= http://localhost:3050

# Optional: use ACCOUNT instead of PRIVATE_KEY (comment the one you don’t want)
#FLAGS = --rpc-url $(BOOJUM_LOCAL_RPC_URL) --account $(ACCOUNT)     --broadcast
FLAGS  = --rpc-url $(BOOJUM_LOCAL_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast

# ── Forge helpers ────────────────────────────────────────────────────────────
update: ; forge update
build : ; forge build

# ── Deployment targets ───────────────────────────────────────────────────────
.PHONY: all \
        deploy-hello-world \
        deploy-with-constructor-args \
        link-library-and-deploy \
        deploy-library-user \
        deploy-via-create2 \
        deploy-and-interact \
        deploy-reverting-constructor \
        test-system-predeploy \
        deploy-with-gas-overrides \
        deploy-dependent-contracts \
        deploy-dynamic-array \
        deploy-emit-event \
        deploy-selfdestruct \
        deploy-delegatecall \
        deploy-upgradeable-proxy \
        deploy-max-gas-constructor \
        deploy-receive-ether \
        deploy-large-bytecode \
        deploy-mapping-init \
        deploy-revert-reason \
        deploy-inline-assembly \
        bootstrap

all: \
  deploy-hello-world \
  deploy-with-constructor-args \
  link-library-and-deploy \
  deploy-library-user \
  deploy-via-create2 \
  deploy-and-interact \
  deploy-reverting-constructor \
  test-system-predeploy \
  deploy-with-gas-overrides \
  deploy-dependent-contracts \
  deploy-dynamic-array \
  deploy-emit-event \
  deploy-selfdestruct \
  deploy-delegatecall \
  deploy-upgradeable-proxy \
  deploy-max-gas-constructor \
  deploy-receive-ether \
  deploy-large-bytecode \
  deploy-mapping-init \
  deploy-revert-reason \
  deploy-inline-assembly

# ── Individual scripts ───────────────────────────────────────────────────────
deploy-hello-world:
	forge script script/01_DeployHelloWorld.s.sol:DeployHelloWorld $(FLAGS) -vvv

deploy-with-constructor-args:
	forge script script/02_DeployWithConstructorArgs.s.sol:DeployWithConstructorArgs $(FLAGS) -vvv

link-library-and-deploy:
	forge script script/03_LinkLibraryAndDeploy.s.sol:LinkLibraryAndDeploy $(FLAGS) -vvv

deploy-library-user:          ## 03b
	forge script script/03b_DeployLibraryUser.s.sol:DeployLibraryUser $(FLAGS) -vvv

deploy-via-create2:
	forge script script/04_DeployViaCreate2.s.sol:DeployViaCreate2 $(FLAGS) -vvv

deploy-and-interact:
	forge script script/05_DeployAndInteract.s.sol:DeployAndInteract $(FLAGS) -vvv

deploy-reverting-constructor:
	forge script script/06_DeployRevertingConstructor.s.sol:DeployRevertingConstructor $(FLAGS) -vvv

test-system-predeploy:
	forge script script/07_TestSystemPredeploy.s.sol:TestSystemPredeploy $(FLAGS) -vvv

deploy-with-gas-overrides:
	forge script script/08_DeployWithGasOverrides.s.sol:DeployWithGasOverrides $(FLAGS) \
		--gas-price 20gwei --gas-limit 5000000 -vvv

deploy-dependent-contracts:
	forge script script/09_DeployDependentContracts.s.sol:DeployDependentContracts $(FLAGS) -vvv

deploy-dynamic-array:
	forge script script/10_DeployWithDynamicArray.s.sol:DeployWithDynamicArray $(FLAGS) -vvv

deploy-emit-event:
	forge script script/11_DeployAndEmitConstructorEvent.s.sol:DeployAndEmitConstructorEvent $(FLAGS) -vvv

deploy-selfdestruct:
	forge script script/12_DeploySelfDestruct.s.sol:DeploySelfDestruct $(FLAGS) -vvv

deploy-delegatecall:
	forge script script/13_DeployDelegateCall.s.sol:DeployDelegateCall $(FLAGS) -vvv

deploy-upgradeable-proxy:
	forge script script/14_DeployUpgradeableProxy.s.sol:DeployUpgradeableProxy $(FLAGS) -vvv

deploy-max-gas-constructor:
	forge script script/15_DeployMaxGasConstructor.s.sol:DeployMaxGasConstructor $(FLAGS) -vvv

deploy-receive-ether:
	forge script script/16_DeployReceiveEther.s.sol:DeployReceiveEther $(FLAGS) -vvv

deploy-large-bytecode:
	forge script script/17_DeployLargeBytecode.s.sol:DeployLargeBytecode $(FLAGS) -vvv

deploy-mapping-init:
	forge script script/18_DeployMappingInit.s.sol:DeployMappingInit $(FLAGS) -vvv

deploy-revert-reason:
	forge script script/19_DeployRevertReason.s.sol:DeployRevertReason $(FLAGS) -vvv

deploy-inline-assembly:
	forge script script/20_DeployUsingInlineAssembly.s.sol:DeployUsingInlineAssembly $(FLAGS) -vvv

# ── Local stack bootstrap helper ─────────────────────────────────────────────
bootstrap: ; scripts/bootstrap_local.sh
# ── Fund local account with ETH from L1-L2 ─────────────────────────────────
fund: ; scripts/fund_rich.sh
