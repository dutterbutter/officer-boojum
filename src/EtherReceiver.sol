// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @notice A contract that simply holds any ETH sent in its constructor
contract EtherReceiver {
    /// @notice Must be payable to accept constructor value
    constructor() payable {}

    /// @notice Fallback to accept plain transfers
    receive() external payable {}
}
