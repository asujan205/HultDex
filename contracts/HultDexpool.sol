// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;
// interface IERC20 {
//     function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
// }

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract HultDexpool {
    
    address public owner;
    address public Token1;

    uint256 public _reversePrice;

  modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    constructor(address _Token1) {
        owner = msg.sender;
        Token1 = _Token1;
    }












    





    
}

