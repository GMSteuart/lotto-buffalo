# Lotto Buffalo

## Requirements

- NPM

## Installation

```bash
npm install
```

Or

```bash
yarn install
```

## Quick Stack

```bash
npm run migrate:dev
truffle exec scripts/fund-contract.js --network ganache 
truffle exec scripts/get-random-number.js --network ganache
truffle exec scripts/enter-lottery.js --network ganache
```

## Test

```bash
npm test
```

## Deploy

If needed, edit the `truffle-config.js` config file to set the desired network 
to a different port. It assumes any network is running the RPC port on 8545.

```bash
npm run migrate:dev
```

For deploying to live networks, Truffle will use `truffle-hdwallet-provider` for your mnemonic and an RPC URL. Set your environment variables `$RPC_URL` and `$MNEMONIC` before running:

```bash
npm run migrate:live
```

## Helper Scripts

There are 3 helper scripts provided with this box in the scripts directory:

- `fund-contract.js`
- `request-data.js`
- `read-contract.js`

They can be used by calling them from `npx truffle exec`, for example:

```bash
$ npx truffle exec scripts/fund-contract.js --network cldev
Using network 'ganache'.

LottoBuffal: 0xB4cda44F1b6538D831b8C7df9c6D5ee4812E7f8D
RandomNumberConsumer: 0xB5cEeb954f9bAD6C4B3043DD6C157A29C1F1347f
tokenAddress: 0xA9134FeCCa04864B4004fA6ac0c1fF93034B0763
0x1700f30654b17a5f00f2e6141b5ba37299414724d526d4b5805958fd082be43c
Truffle v5.1.37 (core: 5.1.37)
Node v14.2.0
```

In the `request-data.js` script, example parameters are provided for you. You can change the oracle address, Job ID, and parameters based on the information available on [our documentation](https://docs.chain.link/docs/testnet-oracles).

```bash
$ npx truffle exec scripts/request-data.js --network live
Using network 'live'.

Creating request on contract: 0x972DB80842Fdaf6015d80954949dBE0A1700705E
0x828f256109f22087b0804a4d1a5c25e8ce9e5ac4bbc777b5715f5f9e5b181a4b
Truffle v5.0.25 (core: 5.0.25)
Node v10.16.3
```

After creating a request on a live network, you will want to wait 3 blocks for the Chainlink node to respond. Then call the `read-contract.js` script to read the contract's state.

```bash
$ npx truffle exec scripts/read-contract.js --network live
Using network 'live'.

21568
Truffle v5.0.25 (core: 5.0.25)
Node v10.16.3
```

```bash
$ truffle exec scripts/get-random-number.js --network ganache

```