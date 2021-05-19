pragma solidity ^0.5.16;

contract MyToken{
     
     uint256 public totalSupply;
     string public name = 'DogeCoin';
     string public symbol = '$';

     mapping(address => uint256) public balanceOf;

     event Transfer(
         address indexed _from,
         address indexed _to,
         uint256 _value
     );
     constructor(uint256 _initialSupply) public {
         totalSupply = _initialSupply;

         /*alocation*/
         balanceOf[msg.sender] = _initialSupply;
     }

     function transfer(address _to, uint256 _value) public returns (bool success){
        require( balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender,_to,_value);
        return true;
     }
  
     
 

}