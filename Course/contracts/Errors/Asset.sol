// SPDX-License-Identifier: GPL-3.0-only

pragma solidity >=0.7.0 <0.9.0;

contract Asset {
    string public state = "onSale";

    error StateNotDefined(uint unit);

    function chanceState(uint newState) public {
        //require(newState == 0 || newState == 1, 'This state is not defined'); // Esta es otra forma de manejar el error
        if(newState == 0){
            state = "onSale";
        } else if(newState == 1){
            state = "notForSale";
        } else {
            revert StateNotDefined(newState);
        }
    }
}