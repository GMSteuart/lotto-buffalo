// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

interface Randomness {
    function getLotteryNumber(uint256 lotteryId, uint256 seed) external;
}
