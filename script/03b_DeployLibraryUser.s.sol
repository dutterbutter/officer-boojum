// SPDX-License-Identifier: UNLICENSED
// script/DeployWithLibrary.s.sol
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/LibraryUser.sol";

contract DeployLibraryUser is Script {
    function run() external {
        vm.startBroadcast();
        new LibraryUser();
        vm.stopBroadcast();
    }
}

