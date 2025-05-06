// script/13_DeployDelegateCall.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/Logic.sol";
import "../src/Proxy.sol";

contract DeployDelegateCall is Script {
    function run() external {
        vm.startBroadcast();
        Logic logic = new Logic();
        // prepare calldata for setNum(123)
        bytes memory initData = abi.encodeWithSignature("setNum(uint256)", 123);
        Proxy proxy = new Proxy(address(logic), initData);
        uint256 stored = proxy.getNum();
        vm.stopBroadcast();
        console.log("Value via delegatecall:", stored);
    }
}
