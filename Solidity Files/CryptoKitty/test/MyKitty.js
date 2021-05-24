var MyKitty = artifacts.require("MyKitty")

contract('MyKitty',(acc)=>{
     
    it("For checking name",()=>{
       return MyKitty.deployed(). then((instance)=>{
       tokeninstance = instance;
       return tokeninstance.name();
    }).then((name)=>{
       assert.equal(name,"CatCoin","Name should be CatCoin");
    });
   });
 
    it("For checking symbol",()=>{
       return MyKitty.deployed(). then((instance)=>{
       tokeninstance = instance;
       return tokeninstance.symbol();
    }).then((sym)=>{
       assert.equal(sym,"C","Symbol should be C");
    });
   });




});