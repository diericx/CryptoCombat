pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/token/StandardToken.sol';
import './ItemBase.sol';

// This provides the methods required for basic non-fungible token
//   transactions
contract ItemOwnership is ItemBase, ERC721 {

    // Check if someone owns said item
    function _owns(address _claimant, uint _tokenId) internal view returns (bool) {
        return itemIndexToOwner[_tokenId] == _claimant;
    }

    // Check if item is approved to transfer to given address
    function _approvedFor(address _claimant, uint _tokenId) internal view returns (bool) {
        return itemIndexToApproved[_tokenId] == _claimant;
    }

    // marks an address as being approved for transferFrom
    function _approve(uint _tokenId, address _approved) internal {
        itemIndexToApproved[_tokenId] = _approved;
    }

    // returns the number of tokens an address owns
    function balanceOf(address _owner) public view returns(uint count) {
        return ownershipTokenCount[_owner];
    }

    // transfers a kitty to another address
    function transfer (address _to, uint _tokenId) external {
        // prevent transfering to null address
        require(_to != address(0));
        // can't transfer to this contract
        require(_to != address(this));
        // must own item to transfer it
        require(_owns(msg.sender, _tokenId));
        //reassign ownership
        _transfer(msg.sender, _to, _tokenId);
    }

    function approve(address _to, uint _tokenId) external {
        // must own the token
        require(_owns(msg.sender, _tokenId));
        // Register the approval
        _approve(_tokenId, _to);
        // Emit approval event
        Approval(msg.sender, _to, _tokenId);
    }

    function totalSupply() public view returns (uint) {
        return items.length - 1;
    }

    function ownerOf(uint _tokenId) external view returns(address owner) {
        owner = itemIndexToOwner[_tokenId];
        require(owner != address(0));
    }

    function tokensOfOwner(address _owner) external view returns(uint[] ownedTokens) {
        uint tokenCount = balanceOf(_owner);

        if (tokenCount == 0) {
            return new uint[](0);
        } else {
            uint256[] memory result = new uint256[](tokenCount);
            uint256 totalItems = totalSupply();
            uint256 resultIndex = 0;

            uint256 itemId;

            for (itemId = 1; itemId <= totalItems; itemId++) {
                if (itemIndexToOwner[itemId] == _owner) {
                    result[resultIndex] = itemId;
                    resultIndex++;
                }
            }

            return result;
        }
    }

}