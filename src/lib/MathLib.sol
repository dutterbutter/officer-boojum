// lib/MathLib.sol
pragma solidity ^0.8.19;

library MathLib {
    function add(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }

    function subtract(uint256 a, uint256 b) external pure returns (uint256) {
        return a - b;
    }

    function multiply(uint256 a, uint256 b) external pure returns (uint256) {
        return a * b;
    }

    function divide(uint256 a, uint256 b) external pure returns (uint256) {
        require(b != 0, "Division by zero");
        return a / b;
    }

    function modulo(uint256 a, uint256 b) external pure returns (uint256) {
        require(b != 0, "Division by zero");
        return a % b;
    }
}
