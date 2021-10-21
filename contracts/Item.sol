pragma solidity ^0.6.0;
import "./ItemManager.sol";
contract Item {
    uint public priceInWei;
    uint public index;
    uint public pricePaid;
    
    ItemManager parentContract;
    //event SuppliedPriceInWei(uint priceinWei, uint priceinMsg);
    
    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) public {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }
    
    receive() external payable {
        require(priceInWei == msg.value, "Only full payments allowed");
        require(pricePaid == 0, "Item is already paid");
        //emit SuppliedPriceInWei(priceInWei, msg.value);
        pricePaid += msg.value;
        (bool success, ) = address(parentContract).call.value(msg.value)(abi.encodeWithSignature("triggerPayment(uint256)",index));
        require(success, "Transaction is not complete. Rolling back");
    }
    
    fallback() external  {}
    
    
}