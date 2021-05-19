var myToken = artifacts.require("myToken.sol")

contract('MyToken',(acc)=>{
             
             
        it('initializes',()=>{
               return myToken.deployed().then((instance)=>{
                       token = instance;
                        return token.name();
               }).then((name)=>{ 
                      assert.equal(name,'DogeCoin',"Wrong name");
                      return token.symbol();
               }).then((symbol)=>{ 
                      assert.equal(symbol,'$','Wrong symbol');
               });
   
         });


 
        it('sets the total supply',()=>{
               return myToken.deployed().then((i)=>{ 
               token = i;
               return token.totalSupply();
               }).then((ts)=>{
                  assert.equal(ts.toNumber(),1000000,'set the total supply to 1,000,000');
                   return token.balanceOf(acc[0]);
               }).then((abal)=>{assert.equal(abal.toNumber(),1000000,'It allocates Intialization');});
        });



        it ("Transfer check",()=>{
               return myToken.deployed().then((instance)=>{
                    tokenInstance = instance;
                    return tokenInstance.transfer.call(acc[0],99999999999);
               }).then(assert.fail).catch((err)=>{
                   assert(err.message.indexOf('revert')>=0, "Low Balance"); 
                   return tokenInstance.transfer.call(acc[1],250000,{from:acc[0]});
               }).then((success)=>{
                   assert.equal(success,true,"returns true");
                   return tokenInstance.transfer(acc[1],250000,{from: acc[0]});
               }).then((recipt)=>{
                   assert.equal(recipt.logs.length,1,"1 event must be emitted");
                   assert.equal(recipt.logs[0].event,"Transfer","1 event must be emitted");
                   assert.equal(recipt.logs[0].args._from,acc[0],"correct transfer");
                   assert.equal(recipt.logs[0].args._to,acc[1],"correct transfer");
                   assert.equal(recipt.logs[0].args._value,250000,"correct transfer");
                   return tokenInstance.balanceOf(acc[1]);
               }).then( (balance)=>{
                  assert.equal(balance,250000,"transfer unsuccessful");
                  return tokenInstance.balanceOf(acc[0]);
                   
               }).then((bal)=>{
                  assert.equal(bal,750000,"Curruption");
               })
        });
});