
var Web3 = require('web3');
var url = 'https://mainnet.infura.io/v3/38f18ea028ce4b71bc9fae37aed0a4d2'
var web3 = new Web3(url);

var address ='0xBE0eB53F46cd790Cd13851d5EFf43D12404d33E8'

var balance =3.3;
web3.eth.getBalance(address,(err,bal)=>{
   
    console.log(web3.utils.fromWei(bal,'ether'));
});
//console.log(web3.utils.fromWei(balance,'ether'));
//eth is object

var account = web3.eth.accounts.create();
console.log(account);
