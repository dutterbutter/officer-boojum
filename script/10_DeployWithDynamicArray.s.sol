// SPDX-License-Identifier: UNLICENSED
// script/10_DeployWithDynamicArray.s.sol
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/DynamicArray.sol";

contract DeployWithDynamicArray is Script {
    function run() external {
        // prepare a dynamic array of five values
        uint256[] memory arr = new uint256[](5);
        for (uint256 i = 0; i < 5; i++) {
            arr[i] = i * 10;
        }

        vm.startBroadcast();
        DynamicArrayUser user = new DynamicArrayUser(arr);
        vm.stopBroadcast();

        console.log("Stored items length:", user.items(4));
    }
}