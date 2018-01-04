# CryptoCombat

CryptoCombat is a DApp developed for Ethereum using Truffle.

This is the core for the game that handles items and characters.

#### Added Functionality:
 * Displays owner of pets that have been adopted
 * Send your pets to another address

#### ToDo:
 * Characters that have slots for equipped items

### Commands:
 * ItemMinting.deployed().then(function(instance){return instance.createRandomItem("seed");});

 * ItemMinting.deployed().then(function(instance){return instance.getItemCountForOwner.call();}).then(function(value){return value.toNumber()});

 * ItemMinting.deployed().then(function(instance){return instance.getItemInfo.call(0);}).then(function(value){return value});

 * ItemMinting.deployed().then(function(instance){return instance.getItemCount.call();}).then(function(value){return value.toNumber()});

 * ItemMinting.deployed().then(function(instance){return instance;});
