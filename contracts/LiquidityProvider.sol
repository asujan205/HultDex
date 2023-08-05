// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


import "./HultDexpool.sol";



contract LiquidityManger {


    address public immutable pool;


    constructor(address _pool) {
        pool = _pool;
    }


    function addLiquidity (uint128 _amount) public {
        IERC20(HultDexpool(pool).Token1()).transferFrom(msg.sender, pool, _amount);
        HultDexpool(pool).mint(msg.sender,_amount);
    }





function  removeLiquidity(uint128 _liquidity) public {
        HultDexpool(pool).burn(_liquidity);
        IERC20(HultDexpool(pool).Token1()).transferFrom(pool , msg.sender,_liquidity);
    }






}