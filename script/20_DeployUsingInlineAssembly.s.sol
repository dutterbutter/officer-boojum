// script/20_DeployUsingInlineAssembly.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/YulInit.sol";

contract DeployUsingInlineAssembly is Script {
    function run() external {
        vm.startBroadcast();
        YulInit y = new YulInit();
        vm.stopBroadcast();
        console.log("Value from YulInit:", y.getVal());
    }
}
