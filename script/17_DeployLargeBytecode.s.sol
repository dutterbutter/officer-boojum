// script/17_DeployLargeBytecode.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/LargeBytecode.sol";

contract DeployLargeBytecode is Script {
    function run() external {
        vm.startBroadcast();
        LargeBytecode lb = new LargeBytecode();
        vm.stopBroadcast();
        console.log("Large string length:", lb.lengthOfLarge());
    }
}