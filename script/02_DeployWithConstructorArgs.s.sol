// SPDX-License-Identifier: UNLICENSED
// script/DeployWithArgs.s.sol
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/Greeter.sol";

contract DeployWithConstructorArgs is Script {
    function run() external {
        string memory greeting = "BoojumBoojumBoojum";
        uint256 deployValue = 0.1 ether;

        vm.startBroadcast();
        new Greeter{value: deployValue}(greeting);
        vm.stopBroadcast();
    }
}
