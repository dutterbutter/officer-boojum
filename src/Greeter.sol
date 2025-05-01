// SPDX-License-Identifier: UNLICENSED
// script/DeployWithArgs.s.sol
pragma solidity ^0.8.19;

contract Greeter {
    string public greeting;
    address public sender;

    constructor(string memory _greeting) payable {
        greeting = _greeting;
        sender = msg.sender;
    }
}