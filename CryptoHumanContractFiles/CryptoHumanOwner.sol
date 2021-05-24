//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "./CryptoHuman.sol";
import "./ERC721.sol";
contract CryptoHumanOwner is CryptoHuman, ERC721{
    mapping (uint => address) humanApprovals;
    modifier OnlyOwnerOf(uint tokenId){
        require(msg.sender == _indexToOwner[tokenId],"Not the owner of the token");
        _;
    }
    function balanceOf(address _owner) external override view returns (uint256) {
        return _ownerToHumanCount[_owner];
    }
  
    function ownerOf(uint256 _tokenId) external override view returns (address) {
        return _indexToOwner[_tokenId];
    }
  
    function _transfer(address from, address  to, uint  tokenId) internal {
      _ownerToHumanCount[to]+=1;
      _ownerToHumanCount[from]-=1;
      _indexToOwner[tokenId] = to;
      emit Transfer(from,to,tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external override payable {
      require (_indexToOwner[_tokenId] == msg.sender || humanApprovals[_tokenId] == msg.sender,"Not the owner to approve");
      _transfer(_from, _to, _tokenId); 
    }

   function approve(address _approved, uint256 _tokenId) external  override payable OnlyOwnerOf(_tokenId) {
       humanApprovals[_tokenId] = _approved;
       emit  Approval(msg.sender, _approved, _tokenId);
    }
    
}