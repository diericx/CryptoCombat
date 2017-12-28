pragma solidity ^0.4.18;

contract ItemFactory {
    
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

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

    Item[] public items;

    mapping (uint => address) public itemToOwner;
    mapping (address => uint) ownerItemCount;

    function _createItem(string _name, uint _dna) private {
        // create the new item and add it to the item list
        uint id = items.push(Item(_name, _dna)) - 1;
        // set the item's owner
        itemToOwner[id] = msg.sender;
        // increase the owner's item count
        ownerItemCount[msg.sender] ++;
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomItem(string _name) public {
        // player cannot generate more than 1 item
        // require(ownerItemCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createItem(_name, randDna);
    }

    function getItem(uint _id) public view returns (
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

    function getItemCountForOwner() public view returns(uint itemCount) {
        return ownerItemCount[msg.sender];
    }
}

// Truffle Commands
//   ItemFactory.deployed().then(function(instance){return instance.createRandomItem.call("name");}).then(function(value){return value});
//   ItemFactory.deployed().then(function(instance){return instance.getItemCountForOwner();}).then(function(value){return value});