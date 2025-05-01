// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import { SelfDestructor } from "../src/SelfDestructor.sol";

contract DeploySelfDestruct is Script {
    function run() external {
        vm.startBroadcast();
        // deploy & immediately self-destruct in constructor
        address sdAddr = address(new SelfDestructor(address(this)));
        vm.stopBroadcast();

        // on-chain after create+destruct, code‐size should be zero
        uint256 size = sdAddr.code.length;
        console.log("code size at self-destructed addr:", size);
    }
}
