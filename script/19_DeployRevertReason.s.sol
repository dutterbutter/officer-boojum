// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/Reverter.sol";

contract DeployRevertReason is Script {
    function run() external {
        vm.startBroadcast();
        try new Reverter() {
            // shouldn't happen
        } catch (bytes memory err) {
            // err = 4-byte selector || ABI-encoded uint256
            uint256 code = _extractUint(err);
            console.log("decoded custom error code:", code);
        }
        vm.stopBroadcast();
    }

    /// @dev skips the 4‐byte selector and reads the next 32 bytes as a uint256
    function _extractUint(bytes memory data) internal pure returns (uint256) {
        require(data.length >= 36, "revert data too short");
        uint256 val;
        assembly {
            // data points at [length][payload...], so payload starts at data+32.
            // skip 4 more bytes: 32 + 4 = 36 (0x24).
            val := mload(add(data, 0x24))
        }
        return val;
    }
}
