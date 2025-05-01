// script/18_DeployMappingInit.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract MappingInit {
    mapping(uint256 => mapping(uint256 => uint256)) public nested;
    constructor() {
        nested[7][13] = 42;
    }
}