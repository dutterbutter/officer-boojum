# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# Common forge flags
FLAGS        = --rpc-url boojum --private-key $(PRIVATE_KEY) --broadcast

update:; forge update

build  :; forge build

.PHONY: all \
        deploy-hello-world \
        deploy-with-constructor-args \
        link-library-and-deploy \
        deploy-via-create2 \
        deploy-and-interact \
        deploy-reverting-constructor \
        test-system-predeploy \
        deploy-with-gas-overrides \
        deploy-dependent-contracts

all: deploy-hello-world \
     deploy-with-constructor-args \
     link-library-and-deploy \
     deploy-via-create2 \
     deploy-and-interact \
     deploy-reverting-constructor \
     test-system-predeploy \
     deploy-with-gas-overrides \
     deploy-dependent-contracts

deploy-hello-world:
	forge script script/01_DeployHelloWorld.s.sol:DeployHelloWorld $(FLAGS)

deploy-with-constructor-args:
	forge script script/02_DeployWithConstructorArgs.s.sol:DeployWithConstructorArgs $(FLAGS)

link-library-and-deploy:
	forge script script/03_LinkLibraryAndDeploy.s.sol:LinkLibraryAndDeploy $(FLAGS)

deploy-via-create2:
	forge script script/04_DeployViaCreate2.s.sol:DeployViaCreate2 $(FLAGS)

deploy-and-interact:
	forge script script/05_DeployAndInteract.s.sol:DeployAndInteract $(FLAGS)

deploy-reverting-constructor:
	forge script script/06_DeployRevertingConstructor.s.sol:DeployRevertingConstructor $(FLAGS)

test-system-predeploy:
	forge script script/07_TestSystemPredeploy.s.sol:TestSystemPredeploy $(FLAGS)

deploy-with-gas-overrides:
	forge script script/08_DeployWithGasOverrides.s.sol:DeployWithGasOverrides $(FLAGS) \
		--gas-price 20gwei --gas-limit 5000000

deploy-dependent-contracts:
	forge script script/09_DeployDependentContracts.s.sol:DeployDependentContracts $(FLAGS)
