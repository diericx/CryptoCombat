var Adoption = artifacts.require("Adoption");
// var ItemAccessControl = artifacts.require("ItemAccessControl");
// var ItemBase = artifacts.require("ItemBase");
// var ItemOwnership = artifacts.require("ItemOwnership");
var ItemMinting = artifacts.require("ItemMinting");

module.exports = function(deployer) {
    deployer.deploy(Adoption);
    deployer.deploy(ItemMinting);
}