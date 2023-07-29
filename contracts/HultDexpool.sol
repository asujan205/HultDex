// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;
// interface IERC20 {
//     function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
// }

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract HultDexpool {

  struct UserInfo {
        uint256 balance;
        uint256 lastContributionTime;
        uint256 interestRate; // In basis points (1 basis point = 0.01%)
        uint256 contributionPeriod; // Contribution period in seconds
    }


    mapping(address => UserInfo) public userInfo;

    uint256 public totalBalance;

     address public _token1address;
    uint256 public _reverse1;


constructor(address token1address) {

    _token1address = token1address;
}

function contribute() external {
    require(userInfo[msg.sender].balance > 0, "User does not have an active pool");

        // Calculate the interest accrued since the last contribution
        uint256 timeSinceLastContribution = block.timestamp - userInfo[msg.sender].lastContributionTime;
        uint256 interestAccrued = (userInfo[msg.sender].balance * userInfo[msg.sender].interestRate * timeSinceLastContribution) / (365 days * 10000);

        // Update the user's balance with the interest accrued
        userInfo[msg.sender].balance += interestAccrued;
        userInfo[msg.sender].lastContributionTime = block.timestamp;
}

function withdraw() external {
    require(userInfo[msg.sender].balance > 0, "User does not have an active pool");

        // Calculate the interest accrued since the last contribution
        uint256 timeSinceLastContribution = block.timestamp - userInfo[msg.sender].lastContributionTime;
        uint256 interestAccrued = (userInfo[msg.sender].balance * userInfo[msg.sender].interestRate * timeSinceLastContribution) / (365 days * 10000);

        // Update the user's balance with the interest accrued
        userInfo[msg.sender].balance += interestAccrued;
        userInfo[msg.sender].lastContributionTime = block.timestamp;

        // Transfer the user's balance to their address
        uint256 balance = userInfo[msg.sender].balance;
        userInfo[msg.sender].balance = 0;
        totalBalance -= balance;
        IERC20(_token1address).transfer(msg.sender, balance);
}

    
}