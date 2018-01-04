var Adoption = artifacts.require("Adoption");
var ItemMinting = artifacts.require("ItemMinting");

module.exports = function(deployer) {
    deployer.deploy(Adoption);
    deployer.deploy(ItemMinting);
}