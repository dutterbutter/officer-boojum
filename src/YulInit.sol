// script/20_DeployUsingInlineAssembly.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract YulInit {
    uint256 public val;

    constructor() {
        assembly {
            sstore(val.slot, 2025)
        }
    }

    function getVal() public view returns (uint256) {
        return val;
    }
}
