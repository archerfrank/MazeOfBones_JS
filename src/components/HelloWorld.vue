<template>
  <div class="hello">
    <span>Welcome：{{username}} </span>
      <br/>
      <span>Address: {{ fromaddress }}</span>
    <br/>
    <span>Balance：{{ balance }}</span> <el-button  size="small"  @click="getnum"  plain>Refresh</el-button>
 
  </div>
  <br/>
  <br/>
  <div class="mt-4">
    <span>Send</span>
    <el-input placeholder="balance" v-model="sendnum"   oninput="value=value.replace(/[^0-9.]/g,'')" >
  </el-input>
  <span>To</span>
  <el-select v-model="selectuser"   placeholder="Select">
    <el-option
      v-for="item in senduserlist"
      :key="item.address"
      :label="item.name"
      :value="item.address">
    </el-option>
  </el-select>
  <el-button   @click="onmove" plain>Submit</el-button>
  </div>
</template>

 
<script  >
  import Web3 from 'web3';
  //import axios from 'axios'
  import abi from '../abi/CodeToken.json' 
  import api from '../abi/api.json' 
  
export default {
  name: 'HelloWorld',
  data() {
  return {
    fromaddress: '',
    userlist: [],
    senduserlist: [],
    selectuser: '',
    sendnum:'',
    balance:'',
    username:'',
  }
  },
  mounted() {
      if(window.ethereum){
        window.ethereum.enable().then((res)=>{
          this.fromaddress=res[0];
          this.getnum();
          this.userlist =this.getuserlist();
        
          for(let item in this.userlist){
            if(this.userlist[item].address==this.fromaddress) 
            {
              this.username=this.userlist[item].name
            }
            else
            {
              this.senduserlist.push({name: this.userlist[item].name , address: this.userlist[item].address})
            }
          }
        })
      }
      else
      {
        alert("no metamask");
      }

  },
  methods:{
    async getnum()
    {
      let that=this
      var web3= web3 =new Web3(window.web3.currentProvider)
      let ethContract=new web3.eth.Contract(abi.abi,"0xcBCF8B1f24E8BEd6471Fa05E1B35053C3d99285B")
       ethContract.methods.balanceOf(this.fromaddress).call().then(function(result){that.balance=result})
    },
    onmove()
    {
      let selectusername=''
      let selectuseraddress=''
      for(let item in this.senduserlist){
        if(this.senduserlist[item].address==this.selectuser)
        {
          selectusername=this.senduserlist[item].name
          selectuseraddress=this.senduserlist[item].address
        }
      }
      if(this.sendnum=='')
      {
        alert("please input send number");
        return
      }
      if(this.selectuser=='')
      {
        alert("please select user");
        return
      }
      if(this.sendnum>this.balance)
      {
        alert("Insufficient balance");
        return
      }
      var web3= web3 =new Web3(window.web3.currentProvider)
      let ethContract=new web3.eth.Contract(abi.abi,"0xcBCF8B1f24E8BEd6471Fa05E1B35053C3d99285B")
      ethContract.methods.move(selectuseraddress, web3.utils.toWei(this.sendnum, 'wei'),this.username,selectusername).send({from:this.fromaddress}).then(this.getnum())
    },
    getuserlist()
    {
      return  api._embedded.accounts
    }
 
  },

}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
 .el-input {
  width: 400px
 }
</style>
