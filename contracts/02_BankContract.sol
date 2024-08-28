pragma solidity 0.4.24;


interface Regulator {
    function checkValue(uint amount) returns (bool);
    function loan() returns (bool);
}

contract Bank is Regulator{
    uint private value;


    constructor  (uint amount) public {
        value=amount;
    }

    function deposit(uint amount){
        value+=amount;
    }

    function withdrawl(uint amount){
        value-=amount;
    }

    function balance() returns (uint){
        return value;
    }

    function checkValue(uint amount) returns (bool){
        return value>=amount;
    }

    function loan() returns (bool){
        return value>0;
    }


}

contract MyFirstContract is Bank(10) {
    string private name;
    uint private age;

    function setName(string newName){
        name=newName;
    }

    function getName() public view returns (string){
        return name;
    }

    function setAge(uint newAge){
        age=newAge;
    }

    function getAge() public view returns (uint){
        return age;
    }
}
