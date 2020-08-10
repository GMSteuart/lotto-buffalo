// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/VRFRequestIDBase.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";

import {Governance} from "./interfaces/Governance.sol";
import {Lottery} from "./interfaces/Lottery.sol";

contract RandomNumberConsumer is VRFConsumerBase {
    Governance public governance;

    bytes32 internal keyHash;

    /**
     * Fee for requesting a random number from the VRF
     */
    uint256 internal fee;

    /**
     * Mapping of lottery id => randomn result number
     */
    mapping(uint256 => uint256) public randomResults;

    /**
     * Mapping of requestId to lotteryId
     */
    mapping(bytes32 => uint256) public requestIds;

    /**
     * Constructor inherits VRFConsumerBase
     *
     * Network: Ropsten
     * Chainlink VRF Coordinator addresses:
     *      Local:      0x88Fd2bAd06285b90341458731dEc2c180cd2e892
     *      Ropsten:    0xf720CF1B963e0e7bE9F58fd471EFa67e7bF00cfb
     * LINK token addresses:
     *      Local:      0xF4d0e956464396cEBC998F60C0AB8720161fa4c2
     *      Ropsten:    0x20fE562d797A42Dcb3399062AE9546cd06f63280
     * Key Hash:
     *      Local:      0x555d3f000257eefb2c93b59b0b6ca2b5fedd06375051d32617731f93cfa806af
     *      Ropsten:    0xced103054e349b8dfb51352f0f8fa9b5d20dde3d06f9f43cb2b85bc64b238205
     */
    constructor(
        address _vrfCoordinator,
        address _link,
        address _governance
    ) public VRFConsumerBase(_vrfCoordinator, _link) {
        keyHash = 0x555d3f000257eefb2c93b59b0b6ca2b5fedd06375051d32617731f93cfa806af;
        fee = 0.1 * 10**18; // 0.1 LINK
        governance = Governance(_governance);
    }

    function getLotteryNumber(uint256 lotteryId, uint256 seed) external {
        require(randomResults[lotteryId] == 0, "already-found-random");
        require(governance.lottery() == msg.sender, "not-lottery-address");

        bytes32 _requestId = getRandomNumber(seed);
        requestIds[_requestId] = lotteryId;
    }

    /**
     * Requests randomness from a user-provided seed
     */
    function getRandomNumber(uint256 userProvidedSeed)
        public
        returns (bytes32 requestId)
    {
        require(
            LINK.balanceOf(address(this)) > fee,
            "Not enough LINK - fill contract with faucet"
        );
        return requestRandomness(keyHash, fee, userProvidedSeed);
    }

    /**
     * Callback function used by VRF Coordinator
     */
    function fulfillRandomness(bytes32 requestId, uint256 randomness)
        internal
        override
    {
        require(
            msg.sender == vrfCoordinator,
            "Fulfilment only permitted by Coordinator"
        );
        uint256 lotteryId = requestIds[requestId];
        randomResults[lotteryId] = randomness;
        Lottery(governance.lottery()).close(randomness);
    }
}
