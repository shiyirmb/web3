// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { HelloWorld } from "./HelloWorld.sol";

contract LearnFactory {
    HelloWorld hw;
    HelloWorld[] hws;

    function createMyHelloWorld() public {
        hw = new HelloWorld();
        hws.push(hw);
    }

    function setMyHelloWorld(uint _index, uint _id, string memory newContent) public {
        hws[_index].setContent(_id, newContent);
    }

    function getMyHelloWorld(uint _index) public view returns(HelloWorld) {
        return hws[_index];
    }

    function sayHelloWorld(uint _index, uint _id) public view returns(string memory) {
        return hws[_index].sayHello(_id);
    }
}