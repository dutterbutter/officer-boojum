// script/19_DeployRevertReason.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @notice A custom error for demonstration
error Foo(uint256 code);

/// @notice Always reverts with a `Foo` error in its constructor
contract Reverter {
    constructor() {
        revert Foo(1234);
    }
}