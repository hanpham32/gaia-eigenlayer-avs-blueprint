// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13;

import "@openzeppelin-upgrades/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin-upgrades/contracts/access/OwnableUpgradeable.sol";
import "eigenlayer-contracts/src/contracts/permissions/Pausable.sol";
import "eigenlayer-middleware/src/interfaces/IServiceManager.sol";
import {RegistryCoordinator} from "eigenlayer-middleware/src/RegistryCoordinator.sol";
import {OperatorStateRetriever} from "eigenlayer-middleware/src/OperatorStateRetriever.sol";
import "eigenlayer-middleware/src/libraries/BN254.sol";
import "contracts/src/IGaiaNodeManager.sol";

contract GaiaNodeManager is
    Initializable,
    OwnableUpgradeable,
    Pausable,
    IGaiaNodeManager,
{
    /* CONSTANT */
    uint32 public immutable TASK_RESPONSE_WINDOW_BLOCK;
    uint32 public constant TASK_CHALLENGE_WINDOW_BLOCK = 100;

    /* STORAGE */
    mapping(uint32 => GaiaNodeConfig) private nodeConfigs;
    mapping(address => uint32[]) private operatorTasks;

    /* MODIFIERS */
    modifier onlyTaskOperator(uint32 taskId) {
        require(nodeConfigs[taskId].operator == msg.sender, "Not task operator");
        _;
    }

    constructor(
        IRegistryCoordinator _registryCoordinator,
    ) {
    }
    /* FUNCTIONS */
    // NOTE: this function starts a new Gaia node
    function startGaiaNode(
        string memory network,
        string memory dataDir
    ) external override whenNotPaused returns (uint32) {
        require(bytes(network).length > 0, "Network cannot be empty");
        require(bytes(dataDir).length > 0, "Data directory cannot be empty");

        uint32 taskId = ++latestTaskNum;

        nodeConfigs[taskId] = GaiaNodeConfig({
            network: network,
            dataDir: dataDir,
            isRunning: true,
            startTime: block.timestamp,
            operator: msg.sender
        });

        operatorTasks[msg.sender].push(taskId);

        emit GaiaNodeStarted(
            taskId,
            network,
            dataDir,
            msg.sender,
            block.timestamp
        );
    }

    function stopGaiaNode(
        uint32 taskId
    ) external override whenNotPaused validTaskId(taskId) onlyTaskOperator(taskId) {
        GaiaNodeConfig storage config = nodeConfigs[taskId];
        require(config.operator == msg.sender, "Only operator can stops the node");
        require(nodeConfigs[taskId].isRunning, "Node is not running");
        
        // FIXME: only update isRunning after received client acknowledgement
        config.isRunning = false;

        emit GaiaNodeStopped(
            taskId,
            msg.sender,
            block.timestamp
        );
    }

    function getGaiaNodeStatus(uint32 taskId)
      external view override returns (GaiaNodeStatus memory)
    {
      GaiaNodeConfig storage config = nodeConfigs[taskId];
      require(config.operator != address(0), "Task ID does not exist");
      GaiaNodeStatus memory status;
      status.isRunning = config.isRunning;
      return status;
    }

    // Get all tasks for an operator
    function getOperatorTasks(address operator) 
      external view returns (uint32[] memory) 
    {
      return operatorTasks[operator];
    }

    // Get node configuration details
    function getGaiaNodeConfig(uint32 taskId) 
      external view validTaskId(taskId) returns (GaiaNodeConfig memory) 
    {
      return nodeConfigs[taskId];
    }
}
