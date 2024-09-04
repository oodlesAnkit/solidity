pragma solidity ^0.0.24;

contract EtherTransferTo {
    function() public payable {}
    function getBalance() public returns (uint) {
        return address(this).balance;
    }
}
