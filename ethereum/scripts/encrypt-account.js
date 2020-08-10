const fs = require('fs')
module.exports = async callback => {
  try {
    // first account private key in data/ganache/keys/account-keys.json
    const privateKey = "1634104fcd357f295ba00dba3fca170a494a43b7659a98c10e28e012ed04af0f"
    // config/secrets/password
    const password = "opensaysame"
    const keystore = await web3.eth.accounts.encrypt(privateKey, password)
    console.log(keystore)
    fs.writeFile(`../config/secrets/0x${keystore.address}.json`, JSON.stringify(keystore), err => {
      if (err) {
        callback(err)
      }
      console.log(`Created: ../config/secrets/0x${keystore.address}.json`)
    });
    const decrypted = await web3.eth.accounts.decrypt(keystore, password)
    console.log(decrypted)
    callback()
  } catch(err) {
    callback(err)
  }
}