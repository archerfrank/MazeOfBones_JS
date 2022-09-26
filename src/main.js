import { createApp } from 'vue'
import App from './App.vue'
import Web3 from 'web3'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'

 
const app=createApp(App)
app.use(ElementPlus);
app.config.globalProperties.Web3=Web3
app.mount('#app')
