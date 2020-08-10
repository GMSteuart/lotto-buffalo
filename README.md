# Lotto Buffalo

A Colorado GameJam game

## Installation

```bash
git clone https://github.com/GMSteuart/lotto-buffalo.git
cd lotto-buffalo/ethereum && npm install
cd ../ui && npm install
cd ..
```

## Initialization

```bash
# Get services up and running
docker-compose up -d
# Move into the ethereum directory (truffle)
cd ethereum 
# Run truffle migrations to get contracts up
npx truffle migrate --network ganache
# Fund contracts with LINK
npx truffle exec scripts/fund-contract.js --network ganache
# Fund operator wallet with ETH
npx truffle exec scripts/fund-operator.js --network ganache
# Approve the Chainlink Operator
npx truffle exec scripts/approve-operator.js --network ganache
# Enter all the ganache accounts into the lottery
npx truffle exec scripts/enter-lottery.js --network ganache
# Run web app
cd ../ui
npm run dev
# web app: localhost:3000
# chainlink operator: localhost:6688
```

## Operator Credentials

```
buffalo@lotto.co
colorado
```

## Explorer Credentials

```
Username: NodeyMcNodeFace
Password: u4HULe0pj5xPyuvv
```

## Addresses

Expect the local addresses to be the following:

| Name                   | Address                                    |
| :--------------------- | :----------------------------------------- |
| Migrations             | 0xA07B1c31F0bc5c5d53101D41f53aE1f4442701b8 |
| LinkToken              | 0xF4d0e956464396cEBC998F60C0AB8720161fa4c2 |
| Oracle                 | 0x8886DB5440147798D27E8AB9c9090140b5cEcA47 |
| VRFCoordinator         | 0x88Fd2bAd06285b90341458731dEc2c180cd2e892 |
| LottoBuffaloGovernance | 0x10C5c1065Cf2A073172C02B66A3Ef2Af729A4164 |
| LottoBuffalo           | 0xdf05840e04f6031a7feF386Fd6c3D0972721CE5d |
| RandomNumberConsumer   | 0xDc2552b15A2Ca4305Cb74ec6F4151ca13E8F7974 |
|                        |                                            |
| ChainLink Operator     | 0x0b83e7104B17eb3775F78A4152A7960A43e475dd |

Alarm Job ID: 778633ef18884692adc1fe9592107957

## Truffle Helper Commands

Get contract and operater LINK amounts

```bash
npx truffle exec scripts/get-contracts-link.js --network ganache
```

Get lottery amount

```bash
npx truffle exec scripts/get-lottery-amount.js --network ganache
```


## Fresh Installation

When wanting to start from scratch (i.e. operator has no jobs, updating VRF key, no existing database data, etc)
the following steps are necessary for local development.

If the applications services are running, run `docker-compose down` in the root of this application structure. The 
instructions commands will be ran from here too.

1. Delete the database backup to prevent the database from being initialized with data: `rm data/db/backup.sql`
2. Remove existing database volumes: `docker volume rm lotto-buffalo_db-data lotto-buffalo_explorer-db-data`
3. Start application services: `docker-compose up -d`
4. Create a new alarm job using the `_templates/alarm-job.json` template
   1. #TODO insert command for creating template via cli
   2. Update `ethereum/contracts/LottoBuffalo.sol` with the new job id.
5. Grab the Chainlink Operator's address at `localhost:6688/config`
   1. Update `ethereum/scripts/fund-operator.js` with the new address.
   2. Update `ethereum/scripts/approve-operator.js` with the new address.
6. [Create the VRF key](#Create the keypair for the VRF)
   1. Update `ethereum/contracts/RandomNumberConsumer.sol`
7. [Backup the Database](#Database Backup)
8. Migrate updated contracts to Ganache: `cd ethereum && npx truffle migrate --network ganache`

### Create the keypair for the VRF

```bash
$ docker exec $(docker ps -f name=lotto-buffalo_chainlink -q) chainlink local vrf create -p /run/secrets/node_password 

Created keypair.

Compressed public key (use this for interactions with the chainlink node):
  0x9b06b7f1a4faa9b05c5b2e31930fc137b87d5f9674725524ae01404a4a07dc6801
Uncompressed public key (use this to register key with the VRFCoordinator):
  0x9b06b7f1a4faa9b05c5b2e31930fc137b87d5f9674725524ae01404a4a07dc68c5c560262e79b5750c12dd76b68435ad5292d985472c5cd4c337431156dc7e4b
Hash of public key (use this to request randomness from your consuming contract):
  0x555d3f000257eefb2c93b59b0b6ca2b5fedd06375051d32617731f93cfa806af

The following command will export the encrypted secret key from the db to <save_path>:

chainlink local vrf export -f <save_path> -pk 0x9b06b7f1a4faa9b05c5b2e31930fc137b87d5f9674725524ae01404a4a07dc6801
```

Retrieving the VRF keypair (using example above)

NOTE: There will be PostgreSQL errors about locking the database, but the VRF key will still be exported and the file
created.

```bash
docker exec $(docker ps -f name=lotto-buffalo_chainlink -q) chainlink local vrf export \
  -f vrfkey.json \
  -pk 0x9b06b7f1a4faa9b05c5b2e31930fc137b87d5f9674725524ae01404a4a07dc6801

docker exec $(docker ps -f name=lotto-buffalo_chainlink -q) cat vrfkey.json > config/secrets/vrfkey.json
```

### Database Backup

NOTE: The keystore file is store in the database and the backup file or volume
needs to be removed if changing the nodes keystore credentials.

```bash
docker exec -t lotto-buffalo_db_1 sh -c 'pg_dumpall -c -U postgres'  > data/db/backup.sql
```

## Chainklink CLI Example

Show current working directory

```bash
$ docker exec $(docker ps -f name=lotto-buffalo_chainlink -q) pwd
/root
```

Get job lists

```bash
docker exec $(docker ps -f name=lotto-buffalo_ganache -q) chainlink jobs list -a /run/secrets/apicredentials
```



## Available Accounts

| id   | address                                    |   balance |
| :--- | :----------------------------------------- | --------: |
| (0)  | 0x853A2b7C008f86b1643Df0434B93f9B3848e3E1e | (100 ETH) |
| (1)  | 0x3F3759efCE42B885B15957bc6F0e56359A2D0d16 | (100 ETH) |
| (2)  | 0xAc28183d2FD316077cC19FD719Ed474EA838e138 | (100 ETH) |
| (3)  | 0xd21C526D2157e331A8Ce72E4b335FBF0934E3d24 | (100 ETH) |
| (4)  | 0x1c3965144f82ffca8A398C6656fD891F77a8428F | (100 ETH) |
| (5)  | 0xa3690F5999b55a5Fe2868259613321DEB7D3139a | (100 ETH) |
| (6)  | 0xE7193955ec259A42063f39150a8F658A05a53663 | (100 ETH) |
| (7)  | 0x2E666Fded78869692aa4f82694065D5DB832CEb9 | (100 ETH) |
| (8)  | 0xE0AF9d030e4E4EED4Ef924542Aa6f93ab5a0323D | (100 ETH) |
| (9)  | 0x7f142c45Cc711F649f4C5444A6c67225f87cC643 | (100 ETH) |
| (10) | 0xd38D56f78AAD29C31eFc9e4AC848Bd22B40d6f63 | (100 ETH) |
| (11) | 0xc92068625D54e8898cc9CAaf53A245c03407e610 | (100 ETH) |
| (12) | 0x5eAdd55A5C5e7AF5929AF6182716442e4D6843db | (100 ETH) |
| (13) | 0x48F885A0F5bAB3fC06D3EA213a07bCC9526E09C8 | (100 ETH) |
| (14) | 0x939E67dBE1416489c7F2E8cdB7C85b32C0F910c6 | (100 ETH) |
| (15) | 0xa90A6A2a7ea33dD4Df56fAc92324D87d72AD47Da | (100 ETH) |

## Private Keys

| id   | key                                                                |
| :--- | :----------------------------------------------------------------- |
| (0)  | 0x1634104fcd357f295ba00dba3fca170a494a43b7659a98c10e28e012ed04af0f |
| (1)  | 0xeb281c0dff24887a762df89a11a8302534640b7740f07125e85e487c74aad9c2 |
| (2)  | 0xf2713aee16f3badb72294f653fa5801ed942db500739c17ea21b43089ac5a860 |
| (3)  | 0xe09c1fd092dcbcc51f937037bf5970f81d317543f3a5aaefd7cca771937a9946 |
| (4)  | 0x7156b8e4f87d4df9b3318a771ea7669f2f38fc4e3c2bbf5b46e0816d12e9e9d2 |
| (5)  | 0x76f80fb3299860134f7bbdf40db58bcfc43603f2ac2c14881e99e584dc6099ef |
| (6)  | 0x95e0a720b3fe56154aeaf9e27725017174f44289b6d62ce72adb809023f16e32 |
| (7)  | 0x663feddc2cdaf0c1a27a9413d4f38840ee98cf0fbf321a57d9254750430209f9 |
| (8)  | 0x861a1e1e5f8fe4a120edef1a3199e60752b4010ac64174db9a7e055fbecc5f4f |
| (9)  | 0x3b8756c383f1893c728d636c170ec3eef8252adadd8f569f245b882023b2b515 |
| (10) | 0x7c8ae8a93c238062912cd000b9a385507399eb48ca73c5bf3b4e0f9a9985cda7 |
| (11) | 0x6b4881d7ffca35dea7371eb984861f95e1380276648bd3a10189ef90c100f3c7 |
| (12) | 0x15366a59d271f27e28932934a11c295900b19ba359559f81cc0a8a9660fd9169 |
| (13) | 0x2f8683727e2ed17c36801a7c7c9b9179c876559a22a6bc3d052d517d67006b74 |
| (14) | 0x35fc3779be762f8a921aa8bdeadd7ab98da0f341ceb4f80ee5427c9ba0f825c9 |
| (15) | 0x30f6411ca75a0fd138b848958322b3210b0f43687bdac20a8377382a553111cf |

## HD Wallet                                                                            
                                                                   
Mnemonic:      result soon dose birth swap lonely street staff course snack frog path
Base HD Path:  m/44'/60'/0'/0/{account_index}                                        