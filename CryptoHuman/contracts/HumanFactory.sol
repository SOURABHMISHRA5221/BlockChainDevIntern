//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract HumanFactory is Ownable{
    uint private constant cooldownTime = 10;
    struct Human{
        uint   gene;
        string gender;
        uint   fatherId;
        uint   motherId;
        uint   birthtime;
        uint   generation;
        uint   readytime;
    }
    Human[] public population;
    
    mapping(uint => address) public _indexToOwner;
    mapping(address => uint) public _ownerToHumanCount;
    
    

    event _newHuman(uint id, uint gene, string gender);

    constructor() onlyOwner {
        // dummy humans
        population.push(Human(13243,"male",0,1,block.timestamp,1,block.timestamp));
        _indexToOwner[0] = msg.sender;
        population.push(Human(134542,"female",0,1,block.timestamp,1,block.timestamp));
        _indexToOwner[1] = msg.sender;
        _ownerToHumanCount[msg.sender]+=2;
        
        
    }

    function createHuman (
        uint _fatherId,
        uint _motherId
        
    ) 
    
    public  onlyOwner  returns (bool success)
    {
       require ( msg.sender == _indexToOwner[_motherId],"You don't own this token");
       require (equal(population[_motherId].gender,"female"),"Mother should only be female");
       require (equal(population[_fatherId].gender,"male"),"Father should only be male");
       require (_bothReady(_fatherId,_motherId),"Atleast One parent is not ready");
       string memory gender = _decideGender(_fatherId,_motherId);
       population[_motherId].readytime = _calculateCooldownTime(population[_motherId].generation);
       population[_fatherId].readytime = _calculateCooldownTime(population[_fatherId].generation);
       uint gene = _createGene(_fatherId,_motherId);
       uint generation = population[_motherId].generation+1;
       uint readytime = _calculateCooldownTime(generation);
       Human memory human = Human(gene,gender,_fatherId,_motherId,block.timestamp,generation,readytime);
       population.push(human);
       uint id = population.length-1;
       _indexToOwner[id] = _indexToOwner[_motherId];
       _ownerToHumanCount[_indexToOwner[id]]++;
       emit _newHuman(id,human.gene,human.gender);
       return true;
    }

    function _createGene(uint _fatherId, uint _motherId) private view returns (uint){
         uint rand = uint(keccak256(abi.encodePacked(integerToString(_fatherId+_motherId+block.timestamp))));
         return rand;
    }
    
    function _decideGender(uint _fatherId,uint _motherId) internal view returns (string memory){
        if ( keccak256(abi.encodePacked(_fatherId+_motherId))>keccak256(abi.encodePacked(_motherId+block.timestamp))){
            return "female";
        }
        return "male";
    }
    
    
    function _calculateCooldownTime(uint _generation) internal view returns( uint){
        uint time  = (block.timestamp + cooldownTime*_generation);
        return time;
    }
    
    function _bothReady(uint _fatherId,uint _motherId) internal view returns (bool success){
        if ( block.timestamp < population[_fatherId].readytime || block.timestamp < population[_motherId].readytime ){
            return false;
        }
        return true;
    }
    
   function integerToString(uint v) internal pure returns (string memory) {
        uint maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint i = 0;
        while (v != 0) {
          uint remainder = v % 10;
           v = v / 10;
           reversed[i++] = bytes1(uint8(48 + remainder));
        }
        bytes memory s = new bytes(i); // i + 1 is inefficient
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - j - 1]; // to avoid the off-by-one error
        }
        string memory str = string(s);  // memory isn't implicitly convertible to storage
        return str;
    }
    function equal(string memory a, string memory b) internal pure returns (bool) {
        if(bytes(a).length != bytes(b).length) {
            return false;
        } else {
            return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
        }
    }
}

