// script/17_DeployLargeBytecode.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

// This contract embeds a large string literal to push code-size
contract LargeBytecode {
    string public large =
        "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

    function lengthOfLarge() public view returns (uint256) {
        return bytes(large).length;
    }
}
