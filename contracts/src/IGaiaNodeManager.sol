// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13;

import "eigenlayer-middleware/src/libraries/BN254.sol";

interface IGaiaNodeManager {
    // EVENTS
    event GaiaNodeStarted(
        uint32 indexed taskId,
        string network,
        string dataDir,
        address indexed operator,
        uint256 timestamp
    );

    event GaiaNodeStopped(
        uint32 indexed taskId,
        address indexed operator,
        uint256 timestamp
    );

    // STRUCTS

    struct GaiaNodeConfig {
        string network;
        string dataDir;
        bool isRunning;
        uint256 startTime;
        address operator;
    }

    struct GaiaNodeStatus {
        bool isRunning;
        uint256 uptime;
        address operator;
    }

    // FUNCTIONS
    // NOTE: this function starts a new Gaia node.
    function startGaiaNode(
        string memory network,
        string memory dataDir
    ) external returns (uint32 taskId);

    // NOTE: this function stop the Gaia node.
    function stopGaiaNode(uint32 taskId) external;

    function getGaiaNodeStatus(
        uint32 taskId
    ) external view returns (GaiaNodeStatus memory);
}
