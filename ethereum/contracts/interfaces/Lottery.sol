// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

interface Lottery {
    function close(uint256 randomness) external;
}