const RandomNumberConsumer = artifacts.require('RandomNumberConsumer')

module.exports = async callback => {
  try {
    const randomNumberConsumer = await RandomNumberConsumer.deployed()
    const r = await randomNumberConsumer.getRandomNumber.call('5334')
    callback(r)
  } catch (err) {
    callback(r)
  }
}