// script/10_DeployWithDynamicArray.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract DynamicArrayUser {
    uint256[] public items;
    constructor(uint256[] memory _items) {
        items = _items;
    }
}