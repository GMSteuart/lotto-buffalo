const HDWalletProvider = require('@truffle/hdwallet-provider')

const MNEMONIC =
  process.env.MNEMONIC ||
  'scan suspect taste sugar nose rose coffee sing spider grid mule evoke'

const RPC_URL =
  process.env.RPC_URL ||
  'https://ropsten.infura.io/v3/3cff7384037b4df094b73b47f20832ac'

module.exports = {
  networks: {
    ganache: {
      host: '127.0.0.1',
      port: 8545, // ganache-cli
      // port: 7545, // ganache
      network_id: '*',
      websockets: true
    },
    live: {
      provider: () => {
        return new HDWalletProvider(MNEMONIC, RPC_URL)
      },
      network_id: '*',
      // Necessary due to https://github.com/trufflesuite/truffle/issues/1971
      // Should be fixed in Truffle 5.0.17
      skipDryRun: true,
      // network_id: '3',
      from: '0xa839142F10D1347BA26f18Fbd69d8334CE1e8159',
    },
  },
  compilers: {
    solc: {
      version: '0.6.6',
    },
  },
  mocha: {
    useColors: true
  }
}
