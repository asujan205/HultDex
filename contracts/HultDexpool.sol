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



function mint(address to, uint128 _amount) external {

    require(_amount > 0, "amount must be greater than 0");

    uint256 _token1Amount = _amount * _reversePrice;

    uint256 _fee = _token1Amount * _Fee / 10000;

    uint256 _token1AmountAfterFee = _token1Amount - _fee;

    IERC20(Token1).transferFrom(msg.sender, address(this), _token1AmountAfterFee);

    userLiqiuidityPosition[to].liquidity = _amount;
    userLiqiuidityPosition[to].token1Amount = _token1AmountAfterFee;

    emit minted(to, _amount, _token1AmountAfterFee);

}



}










    





    


