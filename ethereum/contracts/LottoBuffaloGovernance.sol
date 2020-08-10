// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

// import {Governance} from "./interfaces/Governance.sol";

contract LottoBuffaloGovernance {
    address public lottery;
    address public randomness;

    function init(address _lottery, address _randomness) external {
      require(_lottery != address(0), "governance/no-lottery-address-given");
      require(_randomness != address(0), "governance/no-randomnesss-address");
      require(lottery == address(0), "governance/lottery-address-already-set");
      require(randomness == address(0), "governance/randomness-address-already-set");

      lottery = _lottery;
      randomness = _randomness;
    }
}