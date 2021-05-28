//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/**
 * The SupplyChain is used for book keeping of various step in a supply chain
 */
contract SupplyChain {
    bool private pause;
    address private owner;
    
    struct step {
        address   creator;
        uint      item;
        uint256[] precedents; // There could be more than one precedent
    }

    event stepCreated(uint stepId);

    step[] private steps;

    mapping(uint => uint) public lastCreated;

    modifier onlyCOO() { 
        require (msg.sender == owner,"only COO can call this method"); 
        _; 
    }

    modifier whenNotPaused(){
        require(pause != true,"contract is paused by coo");
        _;
    }

    function  Pause(bool to) external onlyCOO {
        pause = to;
    }
    
    constructor() {
        pause = false;
        owner = msg.sender;
        createGenesisStep();
    }
    
    function createGenesisStep() internal {
        uint[] memory dummy;
        step memory newStep = step(msg.sender,0,dummy);
        steps.push(newStep);
        lastCreated[0] = steps.length-1;
        emit stepCreated(lastCreated[0]);
    }
    
    function createStep(uint item, uint[] memory precedents) external whenNotPaused{
        bool instanceRepeated = false;
        for ( uint i = 0; i < precedents.length; i+=1){
            require(isLastOf(precedents[i]),"Append only on last step");
            if( steps[precedents[i]].item == item){
                instanceRepeated = true;
            }
        }

        if( !instanceRepeated){
            require(lastCreated[item] == 0,"Item should be either same as precedent steo or should be a new one");
        }

        step memory newStep = step(msg.sender,item,precedents);
        steps.push(newStep);
        lastCreated[item] = steps.length-1;
        emit stepCreated(lastCreated[item]);
    }

    function isLastOf(uint _step) public view returns(bool success){
        return lastCreated[steps[_step].item] == _step;
    }

    function getprecedents(uint256 _step) external view returns(uint256[] memory){
       return steps[_step].precedents;
    }

    function getStepofId(uint id)external view returns(step memory){
       return steps[id];
    }

}

