//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Ownable{
    address private owner;
    
    constructor (){
        owner = msg.sender;
    }

	modifier onlyOwner() { 
		require (msg.sender == owner,"Only Owner Can use this function"); 
		_; 
	}
	
	 function _getPaid() external payable onlyOwner{
	     address payable _owner = payable(owner);
         _owner.transfer(address(this).balance);
     }
	

}
