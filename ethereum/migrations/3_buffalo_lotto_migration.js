const { LinkToken } = require('@chainlink/contracts/truffle/v0.4/LinkToken')
const { Oracle } = require('@chainlink/contracts/truffle/v0.6/Oracle')
const { VRFCoordinator } = require('@chainlink/contracts/truffle/v0.6/VRFCoordinator')

const LottoBuffalo = artifacts.require('LottoBuffalo')
const LottoBuffaloGovernance = artifacts.require('LottoBuffaloGovernance')
const RandomNumberConsumer = artifacts.require('RandomNumberConsumer')

module.exports = async (deployer, network, [defaultAccount]) => {
  // For live networks, use the 0 address to allow the ChainlinkRegistry
  // contract automatically retrieve the correct address for you
  let Address = {
    LINK: '0x0000000000000000000000000000000000000000',
    VRF_COORDINATOR: '0xf720CF1B963e0e7bE9F58fd471EFa67e7bF00cfb',
    ORACLE: '0xc99B3D447826532722E41bc36e644ba3479E4365'
  }

  let JobId = {
    // ALARM: '2ebb1c1a4b1e4229adac24ee0b5f784f'
    ALARM: '2ebb1c1a4b1e4229adac24ee0b5f784f'
  }

  // Local (development) networks need their own deployment of the LINK
  // token and the Oracle contract
  if (!network.startsWith('live')) {
    try {
      LinkToken.setProvider(deployer.provider)
      Oracle.setProvider(deployer.provider)
      VRFCoordinator.setProvider(deployer.provider)
      
      const _linkToken = await LinkToken.deployed()
      Address.LINK = _linkToken.address

      const _oracle = await Oracle.deployed()
      Address.ORACLE = _oracle.address

      const _vrfCoordinator = await VRFCoordinator.deployed()
      Address.VRF_COORDINATOR = _vrfCoordinator.address
    } catch (err) {
      console.error(err)
    }
  }

  try {
    const _lottoBuffaloGovernance = await deployer.deploy(
      LottoBuffaloGovernance,
      { from: defaultAccount }
    )

    const _lottoBuffalo = await deployer.deploy(
      LottoBuffalo,
      _lottoBuffaloGovernance.address,
      Address.LINK,
      Address.ORACLE,
      { from: defaultAccount }
    )

    const _randomNumberConsumer = await deployer.deploy(
      RandomNumberConsumer,
      Address.VRF_COORDINATOR,
      Address.LINK,
      _lottoBuffaloGovernance.address,
      { from: defaultAccount }
    )

    await _lottoBuffaloGovernance.init(_lottoBuffalo.address, _randomNumberConsumer.address)
  } catch (err) {
    console.error(err)
  }
}
