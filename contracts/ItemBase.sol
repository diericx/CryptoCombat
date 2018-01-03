pragma solidity ^0.4.18;

import './ItemAccessControl.sol';

// This is where we define the most fundamental code shared throughout the core
//   functionality. This includes our main data storage
contract ItemBase is ItemAccessControl {
    /*** EVENTS ***/

    event Transfer(address from, address to, uint256 tokenId);
    //event Birth(address owner, uint256 itemId, uint256 genes);

    /*** DATA TYPES ***/

    // dna: 0123456789ABCDEF
    //  0 - type: sword, staff, head, chest etc.
    //  12 - strength: increases physical attack dmg
    //  34 - dexterity: increases attack speed
    //  56 - defense: decreases incoming damage
    //  78 - speed: increases player speed
    //  9A - wisdom: increases magic attack dmg
    //  BC - vitality: increases health regen speed
    //  DE - skill: skill that this item can use
    struct Item {
        string name;
        uint dna;
    }

    /*** CONSTANTS ***/

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // Array containing Item struct for all items in existence.
    Item[] public items;

    // item index to an owner's addres
    mapping (uint => address) public itemIndexToOwner;
    // count of how many token's an onwer has
    mapping (address => uint) ownershipTokenCount;
    // Mapping of an item's index to an address that has been approved
    //   to call TransferFrom()
    mapping (uint => address) public itemIndexToApproved;

    function _transfer(address _from, address _to, uint _tokenId) internal {
        ownershipTokenCount[_to] ++;
        // transfer ownership
        itemIndexToOwner[_tokenId] = _to;
        // When creating new kittens, _from is 0x0, but we can't account that address
        if (_from != address(0)) {
            ownershipTokenCount[_from] --;
            // clear any previouslt approved ownership exchange
            delete itemIndexToApproved[_tokenId];
        }
        //Emit the transfer event.
        Transfer(_from, _to, _tokenId);
    }

    function _createItem(string _name, uint _dna, address _owner) internal returns(uint) {

        Item memory _item = Item({
            name: _name,
            dna: _dna
        });
        // create the new item and add it to the item list
        uint newItemId = items.push(_item) - 1;
        
        // Assign ownership and emit the Transfer event
        _transfer(0, _owner, newItemId);

        return newItemId;
    }

    function getItemInfo(uint _id) public view returns (
        string name,
        uint dna
    ) {
        // make sure the id is an actual item
        require(_id < items.length);
        // get the item
        Item memory i = items[_id];
        // return variables
        name = i.name;
        dna = i.dna;
    }

    function getAllItems() public view returns (
        Item[]
    ) {
        return items;
    }
    
}