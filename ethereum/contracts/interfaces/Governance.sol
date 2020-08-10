// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

interface Governance {
    function lottery() external returns (address);
    function randomness() external returns (address);
}