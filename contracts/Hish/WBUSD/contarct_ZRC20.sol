// SPDX-License-Identifier: MIT
pragma solidity 0.4.24;

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

interface ZRC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address account, uint256 amount) external   returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    function allowance(address owner, address sender) external returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract WUSD is ZRC20 {
    using SafeMath for uint256;

    string public name = "WethioUSD";
    string public symbol = "WUSD";
    uint256 public decimals = 2;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address=>mapping (address=>uint256)) private _allowances;
    address public owner;

    // event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() public {
        owner = msg.sender;
        totalSupply = 10 * 10 ** decimals; // 10 WUSD with 2 decimals
        balanceOf[owner] = totalSupply;
        emit Transfer(address(0), owner, totalSupply);
    }


    function totalSupply() public view returns (uint256){
        return totalSupply;
    }

    function balanceOf(address account) public view returns(uint256){
        return balanceOf[account];
    }


    function _transfer(address spender,address recipient, uint256 amount) internal {
        require(balanceOf[spender] >= amount, "Insufficient balance");
            require(recipient != address(0), "Invalid address");

            balanceOf[spender] = balanceOf[spender].sub(amount);
            balanceOf[recipient] = balanceOf[recipient].add(amount);
            emit Transfer(spender, recipient, amount);
    } 

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        _transfer(msg.sender,_to,_value);
        return true;
    }

    function mint(uint256 _amount) public onlyOwner returns (bool success) {
        require(_amount > 0, "Mint amount should be greater than zero");
        uint256 amount = _amount * 10 ** decimals;
        totalSupply = totalSupply.add(amount);
        balanceOf[owner] = balanceOf[owner].add(amount);
        emit Mint(owner, amount);
        emit Transfer(address(0), owner, amount);
        return true;
    }

    function burn(uint256 _amount) public onlyOwner returns (bool success) {
        require(_amount > 0, "Burn amount should be greater than zero");
        uint256 amount = _amount * 10 ** decimals;
        require(
            balanceOf[msg.sender] >= amount,
            "Insufficient balance to burn"
        );

        balanceOf[msg.sender] = balanceOf[msg.sender].sub(amount);
        totalSupply = totalSupply.sub(amount);
        emit Burn(msg.sender, amount);
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }

    function allowance(address owner, address spender)view  returns  (uint256){
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public returns (bool){
        _approve(msg.sender,spender,amount);
        return  true;
    }

    function _approve(address owner,address spender, uint256 amount) internal {
        require(owner!=address(0), "ZRC20: approve from the zero address");
        require(spender!=address(0), "ZRC20: approve from the zero address");

        _allowances[owner][spender]=amount;
        emit Approval(owner, spender, amount);
    }


    function transferFrom(address sender, address recipient,uint256 amount) public returns(bool){
        _transfer(sender,recipient,amount);
        _allowances[sender][recipient].sub(amount);
        return true;
    }
}
