// script/13_DeployDelegateCall.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Proxy {
    address public implementation;
    constructor(address _impl, bytes memory data) {
        implementation = _impl;
        (bool success, ) = _impl.delegatecall(data);
        require(success, "Delegatecall failed");
    }
    function getNum() external returns (uint256) {
        (bool success, bytes memory ret) = implementation.delegatecall(
            abi.encodeWithSignature("num()")
        );
        require(success, "Delegatecall getNum failed");
        return abi.decode(ret, (uint256));
    }
}