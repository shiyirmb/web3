// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HelloWorld {
    string defaultContent = "HelloWorld";

    struct Info {
        uint256 id;
        string content;
        address addr;
    }
    Info[] infos;
    mapping (uint id => Info info) infoMapping;

    function sayHello(uint256 _id) public view returns(string memory) {
        if (infoMapping[_id].addr != address(0)) {
            return getContent(infoMapping[_id].content);
        }
        return getContent(defaultContent);
    }

    function setContent(uint256 _id, string memory newContent) public {
        infoMapping[_id] = Info(_id, newContent, msg.sender);
    }

    function getContent(string memory content) internal pure returns(string memory) {
        return string.concat(content, " from shiyi's contract");
    }
}