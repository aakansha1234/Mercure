// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Airdrop} from "../src/Airdrop.sol";

contract AirdropTest is Test {
    // `airProxy` and `air` refer to the same address, but expose different interfaces.
    Airdrop public air;
    TradAirdrop public tair;
    address admin;
    uint root = 6970479697146449196120147817393952331937868613448835845067856222944698628218;

    function setUp() public {
        admin = makeAddr("admin");
        air = new Airdrop(admin);

        vm.startPrank(admin);
        air.setRoot(root);
        vm.stopPrank();
    }


    function testMint() public {
        uint[11] memory addrs;
        addrs[0] = 802933809494131860455082925493303288586736066170;
        addrs[1] = 253486562210967126009990789802080859110172940592;
        addrs[2] = 1452869057814624873441292749241579028282226374888;
        addrs[3] = 1262563437555501063222274837485909380746997276975;
        addrs[4] = 1040773751847601959264403951055354360569004498452;
        addrs[5] = 663874221203333442536301645249935947935446040914;
        addrs[6] = 81422491238516033800333311335220782493900067114;
        addrs[7] = 748226741870319444342534570575435088907554159615;
        addrs[8] = 1289122163139791910839667260359011016110153703709;
        addrs[9] = 1174837345781722589708100672193406061089524617170;
        addrs[10] = 6970479697146449196120147817393952331937868613448835845067856222944698628218;

        uint[2] memory _pA = [0x0dfdaf1819ee09d904f64a78aebfe5edbaf973b81d54109d2e1fda21cab6a339, 0x297fba38b37a36ab1d3b8ff55c7288951b32fbd1c891cc45efa1c9fc6a7cea18];
        uint[2][2] memory _pB = [[0x0a5dc9e39f4b999814f951e0556234ef776f2cc1bd98e63d30abf5e435bb818c, 0x1034575bf6fae2135d71d07073fedcfdf0ab0fa8dee7b4ae7c8cee0b1ba1e22d],[0x28426691b3cb29d6f99cbb6aea88a9d4e38ec151aacadf7d63e0a4b3ed9a1250, 0x0237b1976324ee8d2a1f537a295e5f27983ca6d177c1350062253e2724cbc47d]];
        uint[2] memory _pC = [0x27d57e8c844c2fb3a075231297eb2968bd861c72339ac376067a975c1547cd8b, 0x1042eb34c45e5bdbcbb9d18fa911279bb9bd7aa5022f991ed7376dd7b0f9d781];

        air.claimAirdrop(addrs, _pA, _pB, _pC);
    }
}
