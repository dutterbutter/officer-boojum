// SPDX-License-Identifier: UNLICENSED
// script/DeployWithCreate2.s.sol
pragma solidity ^0.8.19;

contract Child {
    uint public x;
    constructor(uint _x) {
        x = _x;
    }
}