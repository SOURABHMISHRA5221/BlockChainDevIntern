const chai = require("chai");
const expect = chai.expect;
const isEven = require("../scripts/EvenNoChecker.js")

describe("Checking isEven(num) with unit test",()=>{

	it("Should return true for even no",()=>{
       expect(isEven(2)).to.be.true;
	});

	it("Should return false for odd no",()=>{
       expect(isEven(3)).to.be.false;
	});

});