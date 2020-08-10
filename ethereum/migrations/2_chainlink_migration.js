const { LinkToken } = require('@chainlink/contracts/truffle/v0.4/LinkToken')
const { Oracle } = require('@chainlink/contracts/truffle/v0.6/Oracle')
const { VRFCoordinator } = require('@chainlink/contracts/truffle/v0.6/VRFCoordinator')

module.exports = async (deployer, network, [defaultAccount]) => {
  // For live networks, use the 0 address to allow the ChainlinkRegistry
  // contract automatically retrieve the correct address for you
  // Local (development) networks need their own deployment of the LINK
  // token and the Oracle contract
  if (!network.startsWith('live')) {
    try {
      LinkToken.setProvider(deployer.provider)
      Oracle.setProvider(deployer.provider)
      VRFCoordinator.setProvider(deployer.provider)
      
      await deployer.deploy(LinkToken, { from: defaultAccount })
      await deployer.deploy(Oracle, LinkToken.address, { from: defaultAccount })
      await deployer.deploy(VRFCoordinator, LinkToken.address, { from: defaultAccount })
    } catch (err) {
      console.error(err)
    }
  }
}
