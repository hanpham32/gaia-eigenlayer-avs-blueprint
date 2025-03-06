// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13;

import "eigenlayer-contracts/src/contracts/libraries/BytesLib.sol";
import "contracts/src/IGaiaNodeManager.sol";
import "eigenlayer-middleware/src/ServiceManagerBase.sol";

contract GaiaServiceManager is ServiceManagerBase {
  using BytesLib for bytes;

  IGaiaNodeManager public immutable GaiaNodeManager;

  modifier onlyNodeManager() {
    require(
      msg.sender == address(GaiaNodeManager),
      "onlyNodeManager: need to be a Gaia Node Manager"
    );
    _;
  }

  constructor (
    IAVSDirectory _avsDirectory,
    IRewardsCoordinator _rewardsCoordinator,
    IRegistryCoordinator _registryCoordinator,
    IStakeRegistry _stakeRegistry,
    IGaiaNodeManager _GaiaNodeManager
  )
    ServiceManagerBase(
      _avsDirectory,
      _rewardsCoordinator,
      _registryCoordinator,
      _stakeRegistry
    )
  {
    GaiaNodeManager = _GaiaNodeManager;
  }
}
