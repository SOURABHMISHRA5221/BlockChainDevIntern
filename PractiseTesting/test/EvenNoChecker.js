const chai = require("chai");
const expect = chai.expect;
const isEven = require("../scripts/EvenNoChecker.js");


describe("Checking isEven(num)",()=>{
	it("Should return true for even",()=>{
       expect(isEven(2)).to.be.true;
	});
	it("Should return false for odd",()=>{
      expect(isEven(3)).to.be.false;
	});

});