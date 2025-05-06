// SPDX-License-Identifier: UNLICENSED
// script/TestPredeploy.s.sol
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/interfaces/P256Verify.sol";

contract TestPredeploy is Script {
    function run() external {
        vm.startBroadcast();
        bool ok = P256Verify(0x0000000000000000000000000000000000000100).verify( /* … */ );
        console.log("P256 verify returned:", ok);
        vm.stopBroadcast();
    }
}
