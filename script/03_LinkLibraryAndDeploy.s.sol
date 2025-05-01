// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/lib/MathLib.sol";

contract DeployMathLib is Script {
    function run() external {
        // fetch raw creationCode
        bytes memory code = type(MathLib).creationCode;

        vm.startBroadcast();
        address lib;
        assembly {
            lib := create(0, add(code, 0x20), mload(code))
            if iszero(lib) { revert(0, 0) }
        }
        vm.stopBroadcast();

        console.log("MathLib deployed at", lib);
    }
}
