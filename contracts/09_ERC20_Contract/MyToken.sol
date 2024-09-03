pragma solidity ^0.4.24;

import "./ERC20.sol";

contract MyFirstToken is ERC20 {
    string public constant symbol = "MFT";
    string public constant name = "My First Token";
    uint public constant decimals = 18;

    uint private constant __totalSupply = 1000;
    mapping(address => uint) private __balanceOf;
    mapping(address => mapping(address => uint)) private __allowance;

    function MyFirstToken() {
        __balanceOf[msg.sender] = __totalSupply;
    }
    // total supply
    function totalSupply() public constant returns (uint _totalSupply) {
        _totalSupply = __totalSupply;
    }

    // balanceOf
    function balanceOf(
        address _addr
    ) public constant returns (uint _balanceOf) {
        return __balanceOf[_addr];
    }

    // transfer
    function transfer(address _to, uint _value) public returns (bool success) {
        if (_value > 0 && _value <= balanceOf(msg.sender)) {
            __balanceOf[msg.sender] -= _value;
            __balanceOf[_to] += _value;
            return true;
        }
        return false;
    }

    // transferFrom
    function transferFrom(
        address _from,
        address _to,
        uint _value
    ) returns (bool success) {
        if (
            __allowance[_from][msg.sender] > 0 &&
            _value > 0 &&
            __allowance[_from][msg.sender] >= _value
        ) {
            __balanceOf[_from] -= _value;
            __balanceOf[_to] += _value;
            return true;
        }
        return false;
    }

    // approve function
    function approve(address _spender, uint _value) returns (bool success) {
        __allowance[msg.sender][_spender] = _value;
        return true;
    }

    // allowance
    function allowance(
        address _owner,
        address _spender
    ) constant returns (uint remaining) {
        return __allowance[_owner][_spender];
    }
}
