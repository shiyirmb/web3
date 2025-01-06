// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Data Feeds 使用参考 https://docs.chain.link/data-feeds/using-data-feeds
// 注: 第三方服务不能在本地使用，需要部署到测试或者正式网络上
import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// 1.创建收款函数用于收款
// 2.记录投资人&查看投资人投资金额

// 创建众筹合约
contract CrowdFunding {
    // 记录投资人&投资金额
    mapping(address => uint256) public investorToAmount;
    // 设置最小投资金额
    uint256 MIN_AMOUNT = 100 * 10 ** 18; // 100USD
    // 声明喂价变量
    AggregatorV3Interface internal dataFeed;

    constructor() {
        // 初始化喂价变量
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306 // 以太坊-Sepolia测试网-ETH/USD地址
        );
    }

    // 创建收款函数
    function payment() external payable {
        // 验证投资金额是否满足最小投资金额 否则交易将退回
        require(turnEthToUsd(msg.value) >= MIN_AMOUNT, "Send more ETH");
        // 记录投资人及投资金额 多次投资累加金额
        investorToAmount[msg.sender] += msg.value;
    }

    // 获取 ETH/USD 最新的价格
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    function turnEthToUsd(uint256 ethAmount) internal view returns (uint256) {
        // ETH数量 * ETH价格 = 总价格
        uint256 ethPrice = uint256(getChainlinkDataFeedLatestAnswer());
        return ethAmount * ethPrice / (10 ** 8); // ETH/USD 精度为8位
    }
}