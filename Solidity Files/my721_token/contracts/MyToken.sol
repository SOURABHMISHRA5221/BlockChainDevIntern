//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract MyToken{
    
      string public _name;
      
      string public _symbol;
     
      mapping (uint256 => address) public _owners;
     
      mapping (address => uint256) public _balances;
      
      mapping (uint256 => address) public _tokenApprovals;
     
      mapping (address => mapping (address => bool)) public _operatorApprovals;
     
      constructor (string memory n, string memory s){
          _name   = n;
          _symbol = s;
      }

      event Transfer
      (address indexed _from, address indexed _to, uint256 indexed _tokenId);
      
      event Approval
      (address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
      
      event ApprovalForAll
      (address indexed _owner, address indexed _operator, bool _approved);
        
      function isApprovedForAll(address _owner, address _operator) public view returns (bool){
          return _operatorApprovals[_owner][_operator];
      }
      
      function balanceOf(address _owner) external view returns (uint256){
          require(_owner != address(0), "ERC721: balance query for the zero address");
          return _balances[_owner];
      }

      function ownerOf(uint256 tokenId) external view returns (address){
          address currOwner = _owners[tokenId];
          require(currOwner != address(0), "ERC721: owner query for nonexistent token");
          return currOwner;
      }
      
      function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) public payable{
          require(_isApprovedOrOwner(msg.sender, _tokenId), "ERC721: transfer caller is not owner nor approved");
          require(_owners[_tokenId] == _from, "ERC721: transfer of token that is not own");
          require(_to != address(0), "ERC721: transfer to the zero address");
           _tokenApprovals[_tokenId] = _to;
          emit Approval(_owners[_tokenId], _to, _tokenId);

          _balances[_from] -= 1;
          _balances[_to] += 1;
          _owners[_tokenId] = _to;

          emit Transfer(_from, _to, _tokenId);
      }

       
      function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable{
          safeTransferFrom(_from, _to, _tokenId, "");
      }
      
      function transferFrom(address _from, address _to, uint256 _tokenId) external payable{ 
         require(_isApprovedOrOwner(msg.sender, _tokenId), "ERC721: transfer caller is not owner nor approved");
         emit Transfer(_from, _to, _tokenId);
      }
      
      function approve(address _approved, uint256 _tokenId) external payable{
         address owner = _owners[_tokenId];
         require(_approved != owner, "ERC721: approval to current owner");

        require( msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _tokenApprovals[_tokenId] = _approved;
        emit Approval(_owners[_tokenId], _approved, _tokenId);
      }
      
      function setApprovalForAll(address _operator, bool _approved) external{
         require(_operator != msg.sender, "ERC721: approve to caller");
         _operatorApprovals[msg.sender][_operator] = _approved;
         emit ApprovalForAll(msg.sender, _operator, _approved);
      }
      
      function getApproved(uint256 _tokenId) public view returns (address){
         require(_owners[_tokenId] != address(0), "ERC721: approved query for nonexistent token");
         return _tokenApprovals[_tokenId];
      }

      
      
       function _isApprovedOrOwner(address spender, uint256 tokenId) internal view virtual returns (bool) {
             require(_owners[tokenId] != address(0),"Invalid Token");
             address owner = _owners[tokenId];
             return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
       }
       
     
}