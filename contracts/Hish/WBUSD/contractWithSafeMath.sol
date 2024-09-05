// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;

        return c;
    }
}

contract WUSD {
    using SafeMath for uint256;

    string public name = "WethioUSD";
    string public symbol = "WUSD";
    uint8 public decimals = 2;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() public {
        owner = msg.sender;
        totalSupply = 10 * 10**decimals; // 10 WUSD with 2 decimals
        balanceOf[owner] = totalSupply;
        emit Transfer(address(0), owner, totalSupply);
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        require(_to != address(0), "Invalid address");

        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function mint(uint256 _amount) public onlyOwner returns (bool success) {
        require(_amount > 0, "Mint amount should be greater than zero");
        uint256 amount = _amount * 10**decimals;
        totalSupply = totalSupply.add(amount);
        balanceOf[owner] = balanceOf[owner].add(amount);
        emit Mint(owner, amount);
        emit Transfer(address(0), owner, amount);
        return true;
    }

    function burn(uint256 _amount) public onlyOwner returns (bool success) {
        require(_amount > 0, "Burn amount should be greater than zero");
        uint256 amount = _amount * 10**decimals;
        require(balanceOf[msg.sender] >= amount, "Insufficient balance to burn");

        balanceOf[msg.sender] = balanceOf[msg.sender].sub(amount);
        totalSupply = totalSupply.sub(amount);
        emit Burn(msg.sender, amount);
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}
