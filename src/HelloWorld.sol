// SPDX-License-Identifier: UNLICENSED
// script/TestPredeploy.s.sol
pragma solidity ^0.8.19;

/// @notice A simple contract to verify deploy-with-gas overrides works.
contract HelloWorld {
    function hello() public pure returns (string memory) {
        return "Hello, World!";
    }
}