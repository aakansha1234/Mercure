import { MerkleTree as FixedMerkleTree } from "fixed-merkle-tree";
import { default as vmtree } from 'vmtree-sdk';

export class MerkleTree extends FixedMerkleTree {
    constructor({ hasher, levels = 20, leaves = [], zero = 0 }) {
        super(levels, leaves, {
            hashFunction: (left, right) => hasher([left, right]),
            zeroElement: zero,
        });
    };
};

export function verifyMerkleProof({ pathElements, pathIndices, leaf, root }) {
    pathElements.forEach((element, i) => {
        leaf = !pathIndices[i] ?
            vmtree.poseidon([leaf, element]) : vmtree.poseidon([element, leaf]);
    });
    return leaf == root;
}
