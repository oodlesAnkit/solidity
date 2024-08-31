pragma solidity ^0.4.24;

import "./ERC20.sol";

contract MyFirstToken is ERC20 {
    string public constant symbol = "MFT";
    string public constant name = "My First Token";
    uint public constant decimals = 18;
}
