// SPDX-License-Identifier: MIT
pragma solidity ^0.4.24;

import "./library.sol";

contract TestLibrary {
    using IntExtended for uint;

    function testIncrement(uint _base) view returns (uint){
        return _base.increament();
    }
    

    function testDecrement(uint _base) view returns (uint){
        return _base.decrement();
    }
    
    function testIncrementByValue(uint _base, uint value) view returns (uint){
        return _base.decrementByValue(value);
    }

    function testDecrementByValue(uint _base,uint value) view returns (uint){
        return _base.incrementByValue(value);
    }

}