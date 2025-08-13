// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Dex {
    IERC20 public tokenA;
    IERC20 public tokenB;

    uint256 public reserveA;
    uint256 public reserveB;

    constructor(address _tokenA, address _tokenB) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
    }

    function addLiquidity(uint256 amountA, uint256 amountB) public {
        tokenA.transferFrom(msg.sender, address(this), amountA);
        tokenB.transferFrom(msg.sender, address(this), amountB);
        reserveA += amountA;
        reserveB += amountB;
    }

    function swapAforB(uint256 amountAIn) public {
        require(amountAIn > 0, "Invalid amount");
        uint256 amountBOut = (amountAIn * reserveB) / (reserveA + amountAIn);
        tokenA.transferFrom(msg.sender, address(this), amountAIn);
        tokenB.transfer(msg.sender, amountBOut);
        reserveA += amountAIn;
        reserveB -= amountBOut;
    }

    function swapBforA(uint256 amountBIn) public {
        require(amountBIn > 0, "Invalid amount");
        uint256 amountAOut = (amountBIn * reserveA) / (reserveB + amountBIn);
        tokenB.transferFrom(msg.sender, amountBIn);
        tokenA.transfer(msg.sender, amountAOut);
        reserveB += amountBIn;
        reserveA -= amountAOut;
    }
}
