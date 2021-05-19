pragma solidity ^0.5.16;

contract MyToken{
     
     uint256 public totalSupply;
     string public name = 'DogeCoin';
     string public symbol = '$';
     mapping (address => mapping (address => uint256)) public allowed;

     mapping(address => uint256) public balanceOf;
     uint256 private maxi = 2**256 - 1;
     event Transfer(
         address indexed _from,
         address indexed _to,
         uint256 _value
     );
      event Approval(
         address indexed _owner,
         address indexed _spender,
         uint256 _value
     );
     constructor(uint256 _initialSupply) public {
         totalSupply = _initialSupply;
         balanceOf[msg.sender] = _initialSupply;
     }

     function transfer(address _to, uint256 _value) public returns (bool success){
        require( balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender,_to,_value);
        return true;
     }
     
     function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }
     function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        uint256 allowances = allowed[_from][msg.sender];
        require(balanceOf[_from] >= _value && allowances >= _value);
        balanceOf[_to] += _value;
        balanceOf[_from] -= _value;
        if (allowances < maxi ) {
            allowed[_from][msg.sender] -= _value;
        }
        emit Transfer(_from, _to, _value);
        return true;
    }
   
  
     
 

}
