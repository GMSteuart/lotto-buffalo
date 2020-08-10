const LottoBuffalo = artifacts.require('LottoBuffalo')

module.exports = async callback => {
  try {
    const lotto = await LottoBuffalo.deployed()
    const amount = await lotto.getLotteryAmount()
    console.log(`Lottery Amount: ${amount}`)
    callback()
  } catch (err) {
    callback(err)
  }
}