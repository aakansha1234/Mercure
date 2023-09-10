// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Ownable2Step} from "../lib/openzeppelin-contracts/contracts/access/Ownable2Step.sol";
import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Groth16Verifier} from "./merkle_tree_verifier.sol";

contract Airdrop is Groth16Verifier, ERC20, Ownable2Step {
    uint public root;
    mapping(address => bool) public claimed;

    constructor(address _owner) ERC20("permissionless", "PRMSN") {
        _transferOwnership(_owner);
    }

    function setRoot(uint _root) external onlyOwner {
        root = _root;
    }

    function claimAirdrop(uint[11] calldata _addrs, uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC) external {
        require(_addrs[10] == root);
        for (uint i=0; i<10; ++i) {
            require(!claimed[address(uint160(_addrs[i]))]);
            claimed[address(uint160(_addrs[i]))] = true;
            _mint(address(uint160(_addrs[i])), 10);
        }

        require(verifyProof(_pA, _pB, _pC, _addrs), "failed");
    }
}

