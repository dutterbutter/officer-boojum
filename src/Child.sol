// SPDX-License-Identifier: UNLICENSED
// script/DeployWithCreate2.s.sol
pragma solidity ^0.8.19;

contract Child {
    uint256 public x;

    constructor(uint256 _x) {
        x = _x;
    }
}
