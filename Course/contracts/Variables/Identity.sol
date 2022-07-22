// SPDX-License-Identifier: GPL-3.0-only

pragma solidity >=0.7.0 <0.9.0;

contract Identity {
    uint public idNumber;
    bool public isWorking;
    string public name;
    address public wallet;

    // El constructor se utiliza dentro del contrato para inicializar las varibales de estado
    // Recibe los valores iniciales como parametros cuando se despliega el contrato
    constructor(uint _idNumber, bool _isWorking, string memory _name){
        idNumber = _idNumber;
        isWorking = _isWorking;
        name = _name;
        wallet = msg.sender;
    }
}