// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'

import BoostrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import './assets/css/readus.css'

import VueNativeSock from 'vue-native-websocket'

Vue.config.productionTip = false

Vue.use(BoostrapVue)
Vue.use(VueNativeSock, 'ws://192.168.99.100/echo', { format: 'json' })

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
