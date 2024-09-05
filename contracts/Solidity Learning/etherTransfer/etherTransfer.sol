pragma solidity ^0.4.24;

contract EtherTransferTo {
    function() public payable {}

    function getBalance() view public returns (uint) {
        return address(this).balance;
    }
}

contract EtherTransferFrom {
    EtherTransferTo private _instance;

    constructor() public {
        _instance = new EtherTransferTo();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getBalanceOfInstance() public view returns (uint) {
        return address(_instance).balance;
    }

    function() public payable {
        bool sent = address(_instance).send(msg.value);
        require(sent, "Failed to send Ether");
    }
}
