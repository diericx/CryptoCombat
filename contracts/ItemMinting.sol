pragma solidity ^0.4.18;

import './ItemBase.sol';

contract ItemMinting is ItemBase {

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomItem(string _name) public returns(uint) {
        // player cannot generate more than 1 item
        // require(ownerItemCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        uint newItemId = _createItem(_name, randDna, msg.sender);
        return newItemId;
    }
}

// Truffle Commands
//   truffle develop
//   ItemBase.deployed().then(function(instance){return instance.getAllItems.call();}).then(function(value){return value});
//   ItemMinting.deployed().then(function(instance){return instance.createRandomItem.call("name");}).then(function(value){return value});
//   ItemFactory.deployed().then(function(instance){return instance.getItemCountForOwner();}).then(function(value){return value});