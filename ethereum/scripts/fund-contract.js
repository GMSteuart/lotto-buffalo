const LinkTokenInterface = artifacts.require('LinkTokenInterface')
const LottoBuffalo = artifacts.require('LottoBuffalo')
const RandomNumberConsumer = artifacts.require('RandomNumberConsumer')

/*
  This script is meant to assist with funding the requesting
  contract with LINK. It will send 1 LINK to the requesting
  contract for ease-of-use. Any extra LINK present on the contract
  can be retrieved by calling the withdrawLink() function.
*/

const payment = process.env.TRUFFLE_CL_BOX_PAYMENT || '1000000000000000000'

module.exports = async callback => {
  try {
    const lottoBuffalo = await LottoBuffalo.deployed()
    const randomNumberConsumer = await RandomNumberConsumer.deployed()

    const linkTokenAddress = await lottoBuffalo.getChainlinkToken()
    const linkToken = await LinkTokenInterface.at(linkTokenAddress)
    
    const fund = async (contract, amount, name) => {
      try {
        const _before = await linkToken.balanceOf(contract.address)
        const tx = await linkToken.transfer(contract.address, amount)
        const _after = await linkToken.balanceOf(contract.address)

        console.log(`${name} Balance Before: ${_before}`)
        console.log(`${name} Balance After: ${_after}`)
        return tx
      } catch (err) {
        callback(err)
      }
    }

    await fund(lottoBuffalo, payment, 'LottoBuffalo')
    await fund(randomNumberConsumer, payment, 'RandomNumberConsumer')
    callback()
  } catch (err) {
    callback(err)
  }
}
