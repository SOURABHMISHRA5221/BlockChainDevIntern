//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";

contract MyKitty is ERC721{
     struct MyKitty{
        string colour;
     }
     mapping(string => bool) _colourExits;
     MyKitty[] public myKitties;


     constructor (string memory _name,string memory _symbol)
     ERC721(_name , _symbol)
     {
     }
     
     function mint(string memory _color){
          require (!_colourExits[_colour]);
          unit256 _tokenId = myKitties.push(MyKitty(_colour));
          _mint(msg.sender,_tokenId);
           _colourExits[_colour] = true;
      }
}