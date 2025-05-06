// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Greeter.sol";

contract GreeterTest is Test {
    address addr1 = address(0x1);
    address addr2 = address(0x2);

    function testStartPrankOverridesAfterUse() public {
        Greeter greeter = new Greeter("hello");

        // Start prank with addr1
        vm.startPrank(addr1);
        assertEq(greeter.whoAmI(), addr1, "msg.sender should be addr1");

        // Now switch to addr2 (prank has been used once)
        vm.startPrank(addr2);
        assertEq(greeter.whoAmI(), addr2, "msg.sender should now be addr2");

        // Stop prank
        vm.stopPrank();
        assertEq(greeter.whoAmI(), address(this), "msg.sender should be reset to default");
    }

    function testPrankDoesNotStack() public {
        Greeter greeter = new Greeter("hello");

        vm.startPrank(addr1);
        assertEq(greeter.whoAmI(), addr1);

        vm.startPrank(addr2);
        assertEq(greeter.whoAmI(), addr2);

        // This will stop addr2 prank — NOT revert to addr1
        vm.stopPrank();
        assertEq(greeter.whoAmI(), address(this), "Should not revert to addr1 prank does not stack");
    }
}
