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


function AddLiquidity(uint256 amount) public {

    IERC20 token1 = IERC20(_token1address);
    token1.transferFrom(msg.sender, address(this), amount);
    totalBalance += amount;

    _reverse1 += amount;


    userInfo[msg.sender].balance += amount;
    userInfo[msg.sender].lastContributionTime = block.timestamp;
    userInfo[msg.sender].interestRate = 100;
    userInfo[msg.sender].contributionPeriod = 1000;
}


function WithdrawLiquidity(uint256 _amount) external {

    require(userInfo[msg.sender].balance >= _amount, "You don't have enough balance");
    
    uint256 timeElapsed = block.timestamp - userInfo[msg.sender].lastContributionTime;
    uint256 interest = (userInfo[msg.sender].balance * userInfo[msg.sender].interestRate * timeElapsed) / (100 * 365 * 24 * 60 * 60);
    uint256 amount = userInfo[msg.sender].balance + interest;


    IERC20 token1 = IERC20(_token1address);
    token1.transferFrom(address(this), msg.sender, amount);
    totalBalance -= amount;
    _reverse1 -= amount;
    userInfo[msg.sender].balance -= amount;
    userInfo[msg.sender].lastContributionTime = block.timestamp;
    userInfo[msg.sender].interestRate = 100;
    userInfo[msg.sender].contributionPeriod = 1000;
}






    





    
}

