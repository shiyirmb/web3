// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FundToken {
    // 通证名称
    string public tokenName;
    // 通证简称
    string public tokenShortName;
    // 通证总数量
    uint256 public tokenTotal;
    // 记录所有人的通证
    mapping(address => uint256) blanceMapping;
    // 合约拥有者
    address public owner;

    constructor(string memory _tokenName, string memory _tokenShortName) {
        tokenName= _tokenName;
        tokenShortName = _tokenShortName;
        owner = msg.sender;
    }

    // 铸造通证
    function mint(uint256 amount) public {
        blanceMapping[msg.sender] += amount;
        tokenTotal += amount;
    }

    // 通证转账
    function transferToken(uint256 amount, address addr) public {
        require(blanceMapping[msg.sender] >= amount, "You do not have enough token");
        blanceMapping[msg.sender] -= amount;
        blanceMapping[addr] += amount;
    }

    // 查看通证数量
    function viewToken(address addr) public view returns(uint256) {
        return blanceMapping[addr];
    }
}