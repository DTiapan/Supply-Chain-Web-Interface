const ItemManager = artifacts.require("./ItemManager.sol");

contract("ItemManager", accounts => {
    it("should be create the first item at index 0", async function() {
        const itemManagerInstance = await ItemManager.deployed();
        const itemName = "BMW";
        const itemPrice = "500";

        const result = await itemManagerInstance.createItem(itemName, itemPrice, {from:accounts[0]});
        assert.equal(result.logs[0].args._itemIndex,0,"Item is not at the first index"); 

        const item = await itemManagerInstance.items(0);
        assert.equal(item._identifier, itemName, "Item name does not matches");
    }) 
});