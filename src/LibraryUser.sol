// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

import "../src/lib/MathLib.sol";

contract LibraryUser {
    function sum(uint256 a, uint256 b) external pure returns (uint256) {
        return MathLib.add(a, b);
    }
}