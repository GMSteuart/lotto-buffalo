<template>
  <client-only>
    <div id="app" class="app-container p-grid">
      <div class="header p-grid p-dir-col p-align-center p-col-12">
        <h1>Lotto Buffalo</h1>
        <h2>Current Lottery Size: ${{ lotteryAmountUsd }}</h2>
        <img
          class="buffalo"
          alt="Buffalo Lotto logo"
          src="~/assets/buffalo.png"
        />
      </div>
      <AboutCard />
    </div>
  </client-only>
</template>

<script>
import Web3 from 'web3'
const LottoBuffalo = require('../../ethereum/build/contracts/LottoBuffalo.json').abi
const web3 = new Web3('ws://localhost:8545')
let lotto = new web3.eth.Contract(LottoBuffalo, '0xdf05840e04f6031a7feF386Fd6c3D0972721CE5d')

import AboutCard from '~/components/cards/AboutCard.vue'

export default {
    components: {
        AboutCard
    },
    data() {
        return {
            lotteryAmount: 0,
            // TODO: get live price
            usdEthPrice: 400
        }
    },
    computed: {
        lotteryAmountUsd() {
            return web3.utils.fromWei(this.lotteryAmount.toString(), 'ether') * this.usdEthPrice
        }
    },
    web3: {
        lotteryAmount: {
            contract: lotto,
            method: 'getLotteryAmount',
            arguments: []
        }
    }
}
</script>

<style scoped>
#app {
  font-family: "Dosis", -apple-system, BlinkMacSystemFont, "Segoe UI",
    "Helvetica Neue", Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin-top: 60px;
}

.header {
  background: rgb(2, 0, 36);
  background: linear-gradient(
    180deg,
    rgba(2, 0, 36, 1) 0%,
    rgba(0, 81, 47, 1) 30%,
    rgba(109, 179, 63, 1) 100%
  );
}

.buffalo {
  width: 100%;
  max-width: 768px;
  margin-left: 25px;
}

h1 {
  color: #fff;
}

h2 {
  color: rgb(209, 209, 209);
}

body #app .p-button {
  margin-left: 0.2em;
}

form {
  margin-top: 2em;
}
</style>
