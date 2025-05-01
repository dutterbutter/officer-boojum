// SPDX-License-Identifier: UNLICENSED
// script/DeployWithArgs.s.sol
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/Greeter.sol";

contract DeployWithArgs is Script {
    function run() external {
        string memory greeting = "Boojum,Boojum,Boojum!";
        uint256 deployValue = 0.1 ether;

        vm.startBroadcast();
        new Greeter{value: deployValue}(greeting);
        vm.stopBroadcast();
    }
}
