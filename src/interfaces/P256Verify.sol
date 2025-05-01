// SPDX-License-Identifier: UNLICENSED
// script/TestPredeploy.s.sol
pragma solidity ^0.8.19;

interface P256Verify {
    function verify(/* args */) external view returns (bool);
}