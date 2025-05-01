// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/Simple.sol";

contract DeployHelloWorld is Script {
    function run() external {
        vm.startBroadcast();
        new Simple();
        vm.stopBroadcast();
    }
}
