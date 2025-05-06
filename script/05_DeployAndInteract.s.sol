// SPDX-License-Identifier: UNLICENSED
// script/DeployAndCall.s.sol
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/Counter.sol";

contract DeployAndCall is Script {
    function run() external {
        vm.startBroadcast();
        Counter c = new Counter();
        c.inc();
        c.inc();
        vm.stopBroadcast();

        console.log("Final count:", c.count());
    }
}
