// SPDX-License-Identifier: GPL-3.0-only

pragma solidity >=0.7.0 <0.9.0;

contract Sum {
    int number = 100;

    function sum(int a, int b) public pure returns(int result){
        result = a + b /*+ number Si agrego esto, quiebra, por que tiene el keyword pure y no puede acceder a variables de estado */;
    }
}