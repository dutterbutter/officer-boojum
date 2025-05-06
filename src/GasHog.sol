// script/15_DeployMaxGasConstructor.s.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

// This contract will consume nearly all gas in its constructor
contract GasHog {
    constructor() {
        // loop until gasleft is low
        while (gasleft() > 100_000) {
            // trivial operation to burn gas
        }
    }
}
