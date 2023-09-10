// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Airdrop.sol";

contract AirdropScript is Script {
    function setUp() public {}

    function run() public {
        // private: 0xe41c1efdab629e60206f009b032f8772f216d9dd7b627dc59270871732eb41ed
        address admin = 0xCdC98751C0f01396EB2eD88408af6900309d0fd2;

        uint deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Airdrop air = new Airdrop(admin);
        console2.log("air", address(air));

        vm.stopBroadcast();
    }
}
