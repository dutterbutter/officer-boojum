# ─────────────────────────────────────────────────────────────────────────────
# Load environment variables (PRIVATE_KEY, BOOJUM_NET_RPC_URL, etc.)
-include .env

# ─── Environment selection ────────────────────────────────────────────────────
ENVIRONMENT ?= local    # set ENVIRONMENT=boojum for the hosted RPC
ifeq ($(ENVIRONMENT),boojum)
  RPC_URL  := $(BOOJUM_NET_RPC_URL)
  FROM_KEY := $(BOOJUM_NET_RICH_ACCOUNT)
else
  RPC_URL  := $(LOCAL_L2_RPC_URL)
  FROM_KEY := $(PRIVATE_KEY)
endif

FLAGS        := --rpc-url $(RPC_URL) --private-key $(FROM_KEY) --broadcast
FORGE_SCRIPT := forge script
VERBOSITY    := -vvv
# Usage: $(call RUN, <script‐path>, <ContractName>)
RUN          = $(FORGE_SCRIPT) script/$1:$2 $(FLAGS) $(VERBOSITY)

# ─────────────────────────────────────────────────────────────────────────────
.PHONY: help build all \
        clean-local bootstrap fund \
        verify-reverting \
        blockscout-up blockscout-down blockscout-reset

help:
	@echo "Usage: make [TARGET] [ENVIRONMENT=local|boojum]"
	@echo
	@echo "Targets:"
	@grep -E '^[a-zA-Z0-9_-]+:' Makefile \
	  | grep -v '\.PHONY' \
	  | sed 's/:.*//'

# ─── forge build stamp to auto-rebuild when sources change ───────────────────
FORGE_BUILD_STAMP := out/.forge-build
$(FORGE_BUILD_STAMP): $(shell find src test script -type f)
	forge build
	mkdir -p out
	touch $@

build: $(FORGE_BUILD_STAMP)

# ─────────────────────────────────────────────────────────────────────────────
# All deployment scripts
# Note: skips a few (e.g. create2, selfdestruct) that are not deployable
ALL_DEPLOYS = hello-world \
              with-constructor-args \
              library-user \
              and-interact \
              with-gas-overrides \
              dependent-contracts \
              dynamic-array \
              emit-event \
              delegatecall \
              upgradeable-proxy \
              receive-ether \
              large-bytecode \
              mapping-init \
              inline-assembly \

all: $(addprefix deploy-,$(ALL_DEPLOYS))

# ─── Deploy targets ───────────────────────────────────────────────────────────
deploy-hello-world:
	@echo "👉 Deploy HelloWorld"
	@$(call RUN,01_DeployHelloWorld.s.sol,DeployHelloWorld)

deploy-with-constructor-args:
	@echo "👉 Deploy WithConstructorArgs"
	@$(call RUN,02_DeployWithConstructorArgs.s.sol,DeployWithConstructorArgs)

.PHONY: link-library-and-deploy deploy-library-user
link-library-and-deploy:
	@echo "👉 Deploying MathLib…"
	@$(eval MATHLIB_ADDR := \
	  $(shell \
	    $(FORGE_SCRIPT) script/03_LinkLibraryAndDeploy.s.sol:DeployMathLib \
	      $(FLAGS) --json \
	    | grep -oE '0x[0-9a-fA-F]+' \
	    | head -1 \
	  ) \
	)
	@echo "✅ MathLib deployed at $(MATHLIB_ADDR)"

deploy-library-user: link-library-and-deploy
	@echo "👉 Deploying LibraryUser (linked to MathLib @ $(MATHLIB_ADDR))"
	@$(FORGE_SCRIPT) \
	  script/03b_DeployLibraryUser.s.sol:DeployLibraryUser \
	  --libraries src/lib/MathLib.sol:MathLib:$(MATHLIB_ADDR) \
	  $(FLAGS) $(VERBOSITY)

deploy-via-create2:
	@echo "👉 DeployViaCreate2"
	@$(call RUN,04_DeployViaCreate2.s.sol,DeployWithCreate2)

deploy-and-interact:
	@echo "👉 DeployAndInteract"
	@$(call RUN,05_DeployAndInteract.s.sol,DeployAndCall)

deploy-test-system-predeploy:
	@echo "👉 TestSystemPredeploy"
	@$(call RUN,07_TestSystemPredeploy.s.sol,TestPredeploy)

deploy-with-gas-overrides:
	@echo "👉 DeployWithGasOverrides"
	@$(call RUN,08_DeployWithGasOverrides.s.sol,DeployWithGasOverrides)

deploy-dependent-contracts:
	@echo "👉 DeployDependentContracts"
	@$(call RUN,09_DeployDependentContracts.s.sol,DeployComplex)

deploy-dynamic-array:
	@echo "👉 DeployWithDynamicArray"
	@$(call RUN,10_DeployWithDynamicArray.s.sol,DeployWithDynamicArray)

deploy-emit-event:
	@echo "👉 DeployAndEmitConstructorEvent"
	@$(call RUN,11_DeployAndEmitConstructorEvent.s.sol,DeployAndEmitConstructorEvent)

deploy-selfdestruct:
	@echo "👉 DeploySelfDestruct"
	@$(call RUN,12_DeploySelfDestruct.s.sol,DeploySelfDestruct)

deploy-delegatecall:
	@echo "👉 DeployDelegateCall"
	@$(call RUN,13_DeployDelegateCall.s.sol,DeployDelegateCall)

deploy-upgradeable-proxy:
	@echo "👉 DeployUpgradeableProxy"
	@$(call RUN,14_DeployUpgradeableProxy.s.sol,DeployUpgradeableProxy)

deploy-max-gas-constructor:
	@echo "👉 DeployMaxGasConstructor"
	@$(call RUN,15_DeployMaxGasConstructor.s.sol,DeployMaxGasConstructor)

deploy-receive-ether:
	@echo "👉 DeployReceiveEther"
	@$(call RUN,16_DeployReceiveEther.s.sol,DeployReceiveEther)

deploy-large-bytecode:
	@echo "👉 DeployLargeBytecode"
	@$(call RUN,17_DeployLargeBytecode.s.sol,DeployLargeBytecode)

deploy-mapping-init:
	@echo "👉 DeployMappingInit"
	@$(call RUN,18_DeployMappingInit.s.sol,DeployMappingInit)

deploy-revert-reason:
	@echo "👉 DeployRevertReason"
	@$(call RUN,19_DeployRevertReason.s.sol,DeployRevertReason)

deploy-inline-assembly:
	@echo "👉 DeployUsingInlineAssembly"
	@$(call RUN,20_DeployUsingInlineAssembly.s.sol,DeployUsingInlineAssembly)

deploy-evm-predeploys:
	@echo "👉 DeployEVMPredeploys"
	@$(call RUN,00_EVMPredeploys.s.sol,DeployEVMPredeploys)

# ─── Expected‐to‐revert scripts ──────────────────────────────────────
verify-reverting:
	@echo "👉 Verify expected‐reverts"
	@-$(call RUN,06_DeployRevertingConstructor.s.sol,DeployRevert)
	@$(call RUN,19_DeployRevertReason.s.sol,DeployRevertReason)

# ─────────────────────────────────────────────────────────────────────────────
# Helpers for local bootstrap & funding
clean-local:
	@echo "🛠️  Cleaning up local bootstrap environment"
	@bash scripts/clean_local.sh

bootstrap:
	@bash scripts/bootstrap_local.sh

fund:
	@bash scripts/fund_rich.sh

# ─── Blockscout management ───────────────────────────────────────────────────
blockscout-up:
	@echo "⏫ Spinning up Blockscout…"
	@BLOCKSCOUT_DIR=${BLOCKSCOUT_DIR:-blockscout} CHAIN_TYPE=${CHAIN_TYPE:-default} \
		bash scripts/blockscout_up.sh

blockscout-down:
	@echo "🔻 Shutting down Blockscout & wiping volumes"
	@bash scripts/blockscout_down.sh

blockscout-reset:
	@echo "🧹 Resetting Blockscout data…"
	@bash scripts/blockscout_reset.sh

# ─────────────────────────────────────────────────────────────────────────────
# ── Execution-spec-tests runner ───────────────────────────────────────────────
.PHONY: setup-exec-tests
setup-exec-tests:
	@echo "🔧 Setting up Ethereum execution-spec-tests..."
	@bash scripts/spec_test_setup.sh

.PHONY: exec-tests
exec-tests: setup-exec-tests
	@echo
	@echo "🧪 Running Cancun execution-spec tests…"
	@RPC_ENDPOINT=$(RPC_URL)               \
	SEED_KEY=$(FROM_KEY)                   \
	bash scripts/run_spec_tests_cancun.sh
