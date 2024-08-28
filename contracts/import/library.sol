pragma solidity 0.4.24;


library IntExtended{
    function increament(uint _self) returns (uint){
        return _self+1;
    }

    function decrement(uint _self) returns (uint){
        return _self-1;
    }

    function incrementByValue(uint _self,uint value) returns (uint){
        return _self+value;
    }
     function decrementByValue(uint _self,uint value) returns (uint){
        return _self-value;
    }
}
