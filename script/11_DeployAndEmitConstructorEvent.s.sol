// script/11_DeployAndEmitConstructorEvent.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/EventEmitter.sol";

contract DeployAndEmitConstructorEvent is Script {
    function run() external {
        vm.startBroadcast();
        address emitter = address(new EventEmitter());
        vm.stopBroadcast();
        console.log("EventEmitter deployed at", emitter);
    }
}
