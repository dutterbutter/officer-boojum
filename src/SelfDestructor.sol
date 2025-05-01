// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @notice Immediately self‐destructs in its constructor
contract SelfDestructor {
    /// @param recipient the address to receive any ETH in this contract
    constructor(address recipient) payable {
        // starting with Solidity 0.8.20 EIP-6780 makes this a no-op
        // after the constructor finishes—but it still works in‐creation.
        selfdestruct(payable(recipient));
    }
}
