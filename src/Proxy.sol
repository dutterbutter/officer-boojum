// src/Proxy.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Proxy {
  uint256 public num;
  address public implementation;

  constructor(address _impl, bytes memory data) {
    implementation = _impl;
    (bool ok, ) = _impl.delegatecall(data);
    require(ok, "Delegatecall failed");
  }

  function getNum() external view returns (uint256) {
    return num;
  }
}
