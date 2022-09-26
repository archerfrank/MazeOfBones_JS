<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
 
    <el-button   @click="get" plain>addressid</el-button>
    <el-button   @click="gethy" plain>getabi</el-button>
    <el-button   @click="getnum" plain>balanceOf</el-button>
    <el-button   @click="onmove" plain>move</el-button>
  </div>
</template>

<script>
  import Web3 from 'web3';
  import axios from 'axios'
  import abi from '../abi/CodeToken.json' 
 

export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  data() {
  return {
    fromaddress: '',
  }
  },
  mounted() {
    if(window.ethereum){
        console.log ("metamask")
        window.ethereum.enable().then((res)=>{
          this.fromaddress=res[0];
          console.log (res[0])})
       
      }
      else
      {
        console.log ("no metamask")
      }
  },
  methods:{
    get(){
      alert(this.fromaddress);
    },
    gethy()
    {
        axios.get("https://api-ropsten.etherscan.io/api?module=contract&action=getabi&address=0xa888Ad80b903FF9c8870474b0FB925Af6578D835&apikey=HQG2Y3ZTXKFZG7GREIQQP3SVHYV8T8P3AA")
        .then(function (response) {
            // handle success
            console.log(response);
          })
    },
    getnum()
    {
      var web3= web3 =new Web3(window.web3.currentProvider)
      let ethContract=new web3.eth.Contract(abi.abi,"0xcBCF8B1f24E8BEd6471Fa05E1B35053C3d99285B")
      let balance =ethContract.methods.balanceOf(this.fromaddress).call()
      console.log(balance);
    },
    onmove()
    {
      var web3= web3 =new Web3(window.web3.currentProvider)
      let ethContract=new web3.eth.Contract(abi.abi,"0xcBCF8B1f24E8BEd6471Fa05E1B35053C3d99285B")
      let balance =ethContract.methods.move("0x3d36853ab2e8975fa092d21605afAe1ca99082F0", web3.utils.toWei('1', 'kwei'),"haojie","xinhui").send({from:this.fromaddress}) // call()
      console.log(balance);
    },
  },

}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
