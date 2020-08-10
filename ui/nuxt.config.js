
export default {
  mode: 'universal',
  /*
  ** Headers of the page
  */
  head: {
    title: 'Lotto Buffalo',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'A Blockchain Game for the Colorado Lottery GameJam' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },
  /*
  ** Customize the progress-bar color
  */
  loading: { color: '#fff' },
  /*
  ** Global CSS
  */
  css: [
    { src: 'primevue/resources/primevue.min.css'},
    { src: 'primevue/resources/themes/saga-green/theme.css'},
    { src: 'primeicons/primeicons.css'},
    { src: 'primeflex/primeflex.css'},
  ],
  /*
  ** Plugins to load before mounting the App
  */
    plugins: [
        '@/plugins/primevue.js',
        '@/plugins/web3.js',
  ],
  /*
  ** Nuxt.js dev-modules
  */
  buildModules: [
  ],
  /*
  ** Nuxt.js modules
  */
  modules: [
  ],
  /*
  ** Build configuration
  */
    build: {
      transpile: ['primevue'],
    /*
    ** You can extend webpack config here
    */
    extend (config, ctx) {
    }
  }
}
