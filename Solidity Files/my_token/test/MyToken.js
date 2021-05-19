const MyToken = artifacts.require('MyToken');

require('chai').should();

contract('MyToken',(accounts)=>{

    beforeEach(async ()=> {
      this.token = await MyToken.new("Dogecoin","$");

    })
    describe('Token attributes',()=>{
       it('Has the correct name',async ()=>{
          const  name = await this.token.name();
          name.should.equal("Dogecoin");
        })


       it('Has the correct symbol',async ()=>{
          const symbol = await this.token.symbol();
          symbol.should.equal("$");
       })
   })


});