// SPDX-License-Identifier: UNLICENSED
// script/08_DeployWithGasOverrides.s.sol
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/HelloWorld.sol";

contract DeployWithGasOverrides is Script {
    function run() external {
        vm.startBroadcast();
        new HelloWorld();
        vm.stopBroadcast();
    }
}
