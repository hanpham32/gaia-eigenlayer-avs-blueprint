// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13;

import "eigenlayer-contracts/src/contracts/libraries/BytesLib.sol";
import "contracts/src/ITangleTaskManager.sol";
import "eigenlayer-middleware/src/ServiceManagerBase.sol";

/**
 * @title A smart contract to manage EigenLayer Operator services on Tangle.
 * @author Han Pham.
 */
contract TangleServiceManager is ServiceManagerBase {
    ITangleTaskManager public immutable TangleTaskManager;

    /// @notice when applied to a function, ensures that the function is only callable by the `registryCoordinator`.
    modifier onlyTangleTaskManager() {
        require(
            msg.sender == address(TangleTaskManager),
            "only TangleTaskManager!"
        );
        _;
    }

    constructor(
        IAVSDirectory _avsDirectory,
        IRewardsCoordinator _rewardsCoordinator,
        IRegistryCoordinator _registryCoordinator,
        IStakeRegistry _stakeRegistry,
        ITangleTaskManager _TangleTaskManager
    )
        ServiceManagerBase(
            _avsDirectory,
            _rewardsCoordinator,
            _registryCoordinator,
            _stakeRegistry
        )
    {
        TangleTaskManager = _TangleTaskManager;
    }
}
