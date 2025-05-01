// script/15_DeployMaxGasConstructor.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/GasHog.sol";

contract DeployMaxGasConstructor is Script {
    function run() external {
        vm.startBroadcast();
        new GasHog();
        vm.stopBroadcast();
    }
}