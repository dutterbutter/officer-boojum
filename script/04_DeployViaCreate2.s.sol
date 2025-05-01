// SPDX-License-Identifier: UNLICENSED
// script/DeployWithCreate2.s.sol
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/Child.sol";

contract DeployWithCreate2 is Script {
    function run() external {
        bytes32 salt = keccak256("Boojum");
        bytes memory bytecode = type(Child).creationCode;
        uint256 arg = 123;

        bytecode = abi.encodePacked(bytecode, abi.encode(arg));

        vm.startBroadcast();
        address deployed;
        address deployed2;
        assembly {
            deployed := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
            if iszero(deployed) { revert(0, 0) }
        }

        // deploy with syntax sugar 
        deployed2 = address(new Child{salt: salt}(arg));
        vm.stopBroadcast();

        console.log("Deployed at:", deployed);
        console.log("Deployed Child at:", deployed2);
    }
}
