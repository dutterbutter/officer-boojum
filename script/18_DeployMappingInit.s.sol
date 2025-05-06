// script/18_DeployMappingInit.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/MappingInit.sol";

contract DeployMappingInit is Script {
    function run() external {
        vm.startBroadcast();
        MappingInit m = new MappingInit();
        vm.stopBroadcast();
        console.log("Nested mapping value:", m.nested(7, 13));
    }
}
