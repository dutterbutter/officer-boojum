// SPDX-License-Identifier: UNLICENSED
// script/DeployComplex.s.sol
pragma solidity ^0.8.19;

import "forge-std/Script.sol";

contract A { function foo() external pure returns (uint) { return 42; } }
contract B {
    uint public x;
    constructor(address a) { x = A(a).foo(); }
}
contract C {
    uint public y;
    constructor(address b) { y = B(b).x(); }
}

contract DeployComplex is Script {
    function run() external {
        vm.startBroadcast();
        A a = new A();
        B b = new B(address(a));
        C c = new C(address(b));
        console.log("C.y =", c.y());
        vm.stopBroadcast();
    }
}
