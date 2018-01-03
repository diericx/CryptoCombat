pragma solidity ^0.4.18;

import './ItemOwnership.sol';

contract ItemMinting is ItemOwnership {

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomItem(string _name, address _owner) public {
        // player cannot generate more than 1 item
        // require(ownerItemCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createItem(_name, randDna, _owner);
    }
}

// Truffle Commands
//   truffle develop
//   ItemMinting.deployed().then(function(instance){return instance.createRandomItem.call("name");}).then(function(value){return value});
//   ItemFactory.deployed().then(function(instance){return instance.getItemCountForOwner();}).then(function(value){return value});