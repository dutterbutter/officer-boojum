// SPDX-License-Identifier: UNLICENSED
// script/DeployAndCall.s.sol
pragma solidity ^0.8.19;

contract Counter {
    uint public count;
    function inc() external { count++; }
}