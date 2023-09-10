# Gas optimised ERC20 airdrop
Merkle proof verification offloaded to ZK verification. This PoC lets you batch airdrop claiming for 10 addresses and 1 groth16 verification verifies merkle proofs for all 10 addresses.

For a merkle tree of depth 10, it saves 100 keccak hashes.

## Instructions

Foundry repo x Circom
- At the root, it has the structure of a foundry repo.
- All circuit specific code is in [./circuits](./circuits) directory. Circuits are written in circom.

## Smart contracts

To run and test smart contracts:
- forge install
- forge test

### Deploy on Scroll Sepolia
Update `Airdrop.s.sol` with EOA addresses you control. Set its private key in `.env` file:
```
PRIVATE_KEY=0xaaaaa....
```
Then deploy and verify on etherscan:
```
forge script script/Airdrop.s.sol:AirdropScript --sig "run()" --rpc-url https://sepolia-rpc.scroll.io/ --legacy --broadcast --verify --verifier blockscout  --verifier-url https://blockscout.com/poa/sokol/api\?module\=contract\&action\=verify --chain 534351
```

https://sepolia-blockscout.scroll.io/address/0xc6a648FD6d7e38a056800DeCe3842980002B8c40

## Circuits
- Run `yarn install` in [./circuits/circuits](./circuits/circuits) and [./circuits/scripts](./circuits/scripts).
- Run `gen_keys.sh`.

If you want to generate a new input data for `mint.json`:
- Run `node mint.js` in [`circuits/scripts`](./circuits/scripts/) and copy the output to [`input.json`](./circuits/circuits/input.json`).

