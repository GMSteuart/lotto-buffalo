import Vue from 'vue'
import Web3 from 'web3'
import VueWeb3 from 'vue-web3'

const provider = new Web3.providers.WebsocketProvider('ws://localhost:8545')

Vue.use(VueWeb3, { web3: new Web3(provider) })
