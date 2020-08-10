const { Oracle } = require('@chainlink/contracts/truffle/v0.6/Oracle')

const LinkTokenInterface = artifacts.require('LinkTokenInterface')
const LottoBuffalo = artifacts.require('LottoBuffalo')
const RandomNumberConsumer = artifacts.require('RandomNumberConsumer')

module.exports = async callback => {
  try {
    Address = {
      Oracle: '0x8886DB5440147798D27E8AB9c9090140b5cEcA47'
    }

    const lotto = await LottoBuffalo.deployed()
    const randomNumberConsumer = await RandomNumberConsumer.deployed()

    const linkTokenAddress = await lotto.getChainlinkToken()
    const linkToken = await LinkTokenInterface.at(linkTokenAddress)

    const lottoAmount = await linkToken.balanceOf(lotto.address)
    const randomNumberConsumerAmount = await linkToken.balanceOf(randomNumberConsumer.address)
    const oracleAmount = await linkToken.balanceOf(Address.Oracle)

    console.log(`LottoBuffalo Link: ${lottoAmount}`)
    console.log(`RandomNumberConsumer Link: ${randomNumberConsumerAmount}`)
    console.log(`Oracle Link: ${randomNumberConsumerAmount}`)
    callback()
  } catch (err) {
    callback(err)
  }

}