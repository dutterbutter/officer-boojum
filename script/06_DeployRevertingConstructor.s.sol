// SPDX-License-Identifier: UNLICENSED
// script/DeployRevert.s.sol
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/Exploder.sol";

contract DeployRevert is Script {
    function run() external {
        vm.startBroadcast();
        try new Exploder() {
            // shouldn’t reach
        } catch Error(string memory reason) {
            console.log("Reverted with:", reason);
        }
        vm.stopBroadcast();
    }
}
