const LottoBuffalo = artifacts.require('LottoBuffalo')
const RandomNumberConsumer = artifacts.require('RandomNumberConsumer')

module.exports = async callback => {
  try {
    const lotto = await LottoBuffalo.deployed()
    const rando = await RandomNumberConsumer.deployed()

    const lottoInfo = async () => {
      let _id = await lotto.id.call()
      let _isOpen = await lotto.isOpen()
      let _isClosed = await lotto.isClosed()
      let _isFinished = await lotto.isFinished()
      let _playerCount = await lotto.getPlayerCount()
      let _players = await lotto.getPlayers()
      let _lotteryAmount = await lotto.getLotteryAmount()
      let _alarmAddress = await lotto.getAlarmAddress()
      let _alarmJobId = await lotto.getAlarmJobId()
      let _randomResult = await lotto.RANDOMRESULT.call()

      console.log(`id: ${_id}`)
      console.log(`Stage.open: ${_isOpen}`)
      console.log(`Stage.closed: ${_isClosed}`)
      console.log(`Stage.finished: ${_isFinished}`)
      console.log(`Player Count: ${_playerCount}`)
      console.log(`Players: `, _players)
      console.log(`Lottery Amount: ${_lotteryAmount}`)
      console.log(`Alarm Address: ${_alarmAddress}`)
      console.log(`Alarm Job Id: ${_alarmJobId}`)
      console.log(`Random Result: ${_randomResult}`)
    };

    await lottoInfo();

    callback()
  } catch (err) {
    callback(err)
  }
}
