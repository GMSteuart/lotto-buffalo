

module.exports = async callback => {
  try {
    Address = {
      Operator: '0x0b83e7104B17eb3775F78A4152A7960A43e475dd'
    }
    const [defaultAccount] = await web3.eth.getAccounts()

    const before = await web3.eth.getBalance(Address.Operator)

    const tx = await web3.eth.sendTransaction({
      from: defaultAccount,
      to: Address.Operator,
      value: 1000000000000000000
    })

    const after = await web3.eth.getBalance(Address.Operator)

    console.log(`Transaction Hash: ${tx.transactionHash}`);
    console.log(`Operator ETH Before: ${before}`)
    console.log(`Operator ETH After: ${after}`)

    callback()
  } catch (err) {
    callback(err)
  }
}