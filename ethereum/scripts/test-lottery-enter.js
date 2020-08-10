// relative path might need to be updated depending on location of this script
const lotteryAbi = require("./Lottery.json").abi
const Web3 = require("web3")

// Wallet configuration
const wallet = {
  address: '0xa839142F10D1347BA26f18Fbd69d8334CE1e8159',
  privateKey: '0x769440d67694e2df40bbc1365fc0587bc1113d3ba8089974ff64143e58a16a16'
}
const gas = 5000000
const web3 = new Web3('https://ropsten.infura.io/v3/3cff7384037b4df094b73b47f20832ac')

web3.eth.defaultAccount = wallet.address
web3.eth.accounts.wallet.add(wallet)

const lottery = new web3.eth.Contract(lotteryAbi, '0xd311927b00E539774506785Ed4536B7A811ebf3a')

lottery.methods.OPEN().call().then(r => console.log('open: ', r))

lottery.methods.start_new_lottery().send({
  from: wallet.address,
  gas
}).on("receipt", receipt => {
  console.log('receipt', receipt)
  lottery.methods.OPEN().call().then(r => console.log('open: ', r))
}).on("error", err => {
  console.error(err)
})

module.exports = async callback => {
  const mc = await MyContract.deployed()
  console.log('Creating request on contract:', mc.address)
  const tx = await mc.createRequestTo(
    oracleAddress,
    web3.utils.toHex(jobId),
    payment,
    url,
    path,
    times,
  )
  callback(tx.tx)
}