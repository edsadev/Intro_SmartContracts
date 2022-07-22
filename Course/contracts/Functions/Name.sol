// SPDX-License-Identifier: GPL-3.0-only

pragma solidity >=0.7.0 <0.9.0;

contract Name {
    string name = "Edmundo Salamanca";

    function getName() public view returns(string memory){
        // name="asidnas"; // Esto quebraría el código, ya que trato de mutar una variable de estado
        return name;
    }
}