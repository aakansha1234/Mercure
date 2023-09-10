import { default as vmtree } from 'vmtree-sdk';
import { MerkleTree, verifyMerkleProof } from './util.js';

const mintTree = new MerkleTree({ hasher: vmtree.poseidon, levels: 10, zero: 0 });

/**
 recipient secret keys = [
    '0xb4b0bf302506d14eba9970593921a0bd219a10ebf66a0367851a278f9a8c3d08',
    '0xb81676dc516f1e4dcec657669e30d31e4454e67aa98574eca670b4509878290c',
    '0xa8960bfeaf2fdab4afaa7ba8cf6f10cfdc4c8378537b73f7b018150dd2031b86',
    '0xedda7e2735800a24d33addecb0804a4f21ea911421d9d8aa927c6e9deba06fb6',
    '0x3a7e5c3377e4b33212fdef21909e48b6d2809bf59bec3ea18122925e62a6c083',
    '0x028d163ef0679e4ceac9b208e759b28f058a9df6def9a1fba612861738c94a63',
    '0x080090a1ac2980d3b6c0affb7d812709adfea04d0523bea770fc2b9b843c30fc',
    '0x24f4ee77428235b525d75d03007f08d65fa336f03347b765a5c0f880541b8390',
    '0x53bdff096f729ad88de3be253b321a97933fa57efaf0852e61c7fd017deb605d',
    '0xe41c1efdab629e60206f009b032f8772f216d9dd7b627dc59270871732eb41ed'
]
*/

const requests = [
    { recipient: 802933809494131860455082925493303288586736066170n },
    { recipient: 253486562210967126009990789802080859110172940592n },
    { recipient: 1452869057814624873441292749241579028282226374888n },
    { recipient: 1262563437555501063222274837485909380746997276975n },
    { recipient: 1040773751847601959264403951055354360569004498452n },
    { recipient: 663874221203333442536301645249935947935446040914n },
    { recipient: 81422491238516033800333311335220782493900067114n },
    { recipient: 748226741870319444342534570575435088907554159615n },
    { recipient: 1289122163139791910839667260359011016110153703709n },
    { recipient: 1174837345781722589708100672193406061089524617170n },
]

requests.forEach((v) => v.leaf = v.recipient)
// requests.forEach((v) => v.leaf = vmtree.poseidon([v.recipient]))

// fill up mint tree
console.log(requests);
requests.forEach((request, i) => {
    mintTree.update(i, request.leaf)
})

let input = {};

input.root = mintTree.root.toString();
input.leaf = []

requests.forEach((v) => {
    input.leaf.push(v.leaf.toString())
})

input.pathElements = []
input.pathIndices = []
requests.forEach((requests, i) => {
    console.log(i)
    let path = mintTree.path(i);
    let pathElements = path.pathElements;
    let pathElementsStr = []
    pathElements.forEach((v) => {
        pathElementsStr.push(v.toString())
    })
    input.pathElements.push(pathElementsStr)

    let pathIndices = path.pathIndices;
    let pathIndicesStr = []
    pathIndices.forEach((v) => {
        pathIndicesStr.push(v.toString())
    })
    input.pathIndices.push(pathIndicesStr)
})
console.log(JSON.stringify(input))

// console.log(verifyMerkleProof({ pathElements: input.pathElements[0], pathIndices: input.pathIndices[0], leaf: input.leaf[0], root: mintTree.root }))
