// script/11_DeployAndEmitConstructorEvent.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract EventEmitter {
    event Constructed(address indexed deployer, uint256 timestamp);
    constructor() {
        emit Constructed(msg.sender, block.timestamp);
    }
}