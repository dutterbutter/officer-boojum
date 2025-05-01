// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import { EtherReceiver } from "../src/EtherReceiver.sol";

contract DeployReceiveEther is Script {
    function run() external {
        vm.startBroadcast();
        // now that the constructor is payable, this compiles
        EtherReceiver recv = (new EtherReceiver){ value: 0.5 ether }();
        vm.stopBroadcast();

        console.log("Receiver balance (wei):", address(recv).balance);
    }
}
