// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ArcadeCats is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    mapping(string => uint256) existingURIs;

    constructor() ERC721("ArcadeCats", "ARC") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://";
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function isOwned (string memory uri) public view returns(bool) {
        return existingURIs[uri] == 1;
    }

    function payToMint(address to, string memory uri) public payable returns(uint256) {
        require(existingURIs[uri] != 1, "NFT's already minted");
        require(msg.value >= 0.5 ether, "Pay a minimum of 0.5 ETH");
        
        uint256 newTokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(to, newTokenId);
        _setTokenURI(newTokenId, uri);

        return newTokenId;
    }
    
    function getCount() public view returns(uint256) {
        return _tokenIdCounter.current();
    }
}