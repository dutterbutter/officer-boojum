// script/14_DeployUpgradeableProxy.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract ImplV1 {
    uint256 public x;
    function initialize(uint256 _x) public {
        require(x == 0, "Already initialized");
        x = _x;
    }
}

contract DeployUpgradeableProxy is Script {
    function run() external {
        vm.startBroadcast();
        // deploy admin & logic
        ProxyAdmin admin = new ProxyAdmin(msg.sender);
        ImplV1 impl = new ImplV1();
        // encode initializer
        bytes memory initData = abi.encodeWithSelector(
            ImplV1.initialize.selector,
            777
        );
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(impl),
            address(admin),
            initData
        );
        vm.stopBroadcast();
        console.log("Proxy address:", address(proxy));
    }
}