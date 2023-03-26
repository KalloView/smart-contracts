// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/KalloViewRegistry.sol";

contract DeployKalloViewRegistry is Script {
    function setUp() public { }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PK");
        vm.startBroadcast(deployerPrivateKey);

        KalloViewRegistry kallo = new KalloViewRegistry();
    }
}
