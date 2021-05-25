const chai = require("chai");
const expect = chai.expect;
const isEven = require("../scripts/EvenNoChecker.js");


describe("Checking isEven(num)",()=>{

       it("Should return true for even", async ()=>{
       	   const result = await isEven(2);
       	   expect(result).to.be.true;

       });

       it("Should return false for odd",async()=>{
           const result  = await isEven(3);
           expect(result).to.be.false;
       });



});

