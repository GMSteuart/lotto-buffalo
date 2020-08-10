const { Oracle } = require('@chainlink/contracts/truffle/v0.6/Oracle')

module.exports = async callback => {

  const Address = {
    Operator: '0x0b83e7104B17eb3775F78A4152A7960A43e475dd',
    Oracle: '0x8886DB5440147798D27E8AB9c9090140b5cEcA47'
  }

  try {
    Oracle.setProvider(web3.eth.currentProvider)

    const [defaultAccount] = await web3.eth.getAccounts()
    const oracle = await Oracle.at(Address.Oracle)
    let isAuthorized = await oracle.getAuthorizationStatus(Address.Operator)
    
    console.log('Operator Address: ', Address.Operator)
    console.log('Operator Authorized: ', isAuthorized)

    await oracle.setFulfillmentPermission(Address.Operator, true, { from: defaultAccount })
    isAuthorized = await oracle.getAuthorizationStatus(Address.Operator)

    console.log('Operator Authorized: ', isAuthorized)

    callback()
  } catch (err) {
    callback(err)
  }
}