// script/13_DeployDelegateCall.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Logic {
    uint256 public num;
    function setNum(uint256 _num) external {
        num = _num;
    }
}