const LottoBuffalo = artifacts.require('LottoBuffalo')
const { LinkToken } = require('@chainlink/contracts/truffle/v0.4/LinkToken')
const { Oracle } = require('@chainlink/contracts/truffle/v0.6/Oracle')

module.exports = async (deployer, network, [defaultAccount]) => {
  // For live networks, use the 0 address to allow the ChainlinkRegistry
  // contract automatically retrieve the correct address for you
  if (network.startsWith('live')) {  
    return deployer.deploy(LottoBuffalo, '0x0000000000000000000000000000000000000000')
  }

  // Local (development) networks need their own deployment of the LINK
  // token and the Oracle contract
  LinkToken.setProvider(deployer.provider)
  Oracle.setProvider(deployer.provider)

  try {
    await deployer.deploy(LinkToken, { from: defaultAccount })
    await deployer.deploy(Oracle, LinkToken.address, { from: defaultAccount })
    await deployer.deploy(LottoBuffalo, LinkToken.address)
  } catch (err) {
    console.error(err)
  }
}
