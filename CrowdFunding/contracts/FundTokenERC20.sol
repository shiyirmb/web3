// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 引入 ERC20 标准合约 使用参考：https://docs.openzeppelin.com/contracts/5.x/erc20
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FundToken is ERC20 {
    constructor() ERC20("FundTokenERC20", "FT") {}
}