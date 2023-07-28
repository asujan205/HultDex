// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;


contract HultDexpool {

    struct UserInfo {
        uint256 _Balance;
        uint256 _intrestRate;
        uint256 _lastContributed;

    }


    mapping(address => UserInfo) public userInfo;
    
}