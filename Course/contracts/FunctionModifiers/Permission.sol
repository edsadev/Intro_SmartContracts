// SPDX-License-Identifier: GPL-3.0-only

pragma solidity >=0.7.0 <0.9.0;

contract Permission {
    address private owner;
    string public projectName = "Platzi";

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(
            msg.sender == owner, // Lo que va a validar
            "Only owner can change the project name" // Mensaje que se lanza cuando la validación falle
        );
        _; // Indica donde se va a insertar la lógica de la función
    }

    function changeProjectName(string memory _projectName) public onlyOwner {
        projectName = _projectName;
    }
}