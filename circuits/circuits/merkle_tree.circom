pragma circom 2.1.5;

include "./node_modules/circomlib/circuits/poseidon.circom"; // TODO: consider Poseidon2

// if s == 0 returns [in[0], in[1]]
// if s == 1 returns [in[1], in[0]]
template DualMux() {
    signal input in[2];
    signal input s;
    signal output out[2];

    s * (1 - s) === 0;
    out[0] <== (in[1] - in[0])*s + in[0];
    out[1] <== (in[0] - in[1])*s + in[1];
}

template CheckMerkleProofStrict(levels) {
    signal input leaf;
    signal input pathElements[levels];
    signal input pathIndices[levels];
    signal input root;

    component selectors[levels];
    component hashers[levels];

    for (var i = 0; i < levels; i++) {
        selectors[i] = DualMux();
        selectors[i].in[0] <== i == 0 ? leaf : hashers[i - 1].out;
        selectors[i].in[1] <== pathElements[i];
        selectors[i].s <== pathIndices[i];

        hashers[i] = Poseidon(2);
        hashers[i].inputs[0] <== selectors[i].out[0];
        hashers[i].inputs[1] <== selectors[i].out[1];
    }

    root === hashers[levels - 1].out;
}

template CheckMerkleProof(levels, num_leaves) {
    signal input leaf[num_leaves];
    signal input pathElements[num_leaves][levels];
    signal input pathIndices[num_leaves][levels];
    signal input root;

    for (var i=0; i<num_leaves; i++) {
        CheckMerkleProofStrict(levels)(
            leaf[i],
            pathElements[i],
            pathIndices[i],
            root
        );
    }
}

component main { public [leaf, root] } = CheckMerkleProof(10, 10);
