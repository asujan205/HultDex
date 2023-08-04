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

    uint256 public _Fee;

  modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    struct UserLiqiuidityPosition {
         uint128 liquidity;
            uint256 token1Amount;

      
    }

    event minted(address indexed sender, uint256 amount0, uint256 amount1);

    mapping (address => UserLiqiuidityPosition) public userLiqiuidityPosition;

    constructor(address _Token1) {
        owner = msg.sender;
        Token1 = _Token1;
    }


    function getReverse() public view returns (uint256) {
        return _reversePrice;
    }

    function getFee() public view returns (uint256) {
        return _Fee;
    }





function initialize(address _token1) onlyOwner public {
        Token1 = _token1;

} 


function setFee(uint256 fee) onlyOwner public {
        _Fee = fee;
}



function mint(address to, uint128 _amount) external  returns (uint256 amount){

    require(_amount > 0, "amount must be greater than 0");

     require(IERC20(Token1).transferFrom(msg.sender, address(this), _amount));


    userLiqiuidityPosition[to].liquidity = _amount;

    uint256 amount1 = IERC20(Token1).balanceOf(address(this));

    userLiqiuidityPosition[to].token1Amount = amount1;


    emit minted(to, _amount, amount1);

    return amount1;


}


function burn(uint128 _amount) external  returns (uint256 amount0){


    require(_amount > 0, "amount must be greater than 0");

    require(userLiqiuidityPosition[msg.sender].liquidity >= _amount, "amount must be less than or equal to your liquidity");

   
    return amount0;
    











}



}










    





    


