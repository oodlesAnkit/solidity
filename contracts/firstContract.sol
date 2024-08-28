pragma solidity 0.4.24;

contract MyFirstContract {
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
