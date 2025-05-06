// SPDX-License-Identifier: UNLICENSED
// script/DeployRevert.s.sol
pragma solidity ^0.8.19;

contract Exploder {
    constructor() {
        require(false, "Exploder always fails");
    }
}
