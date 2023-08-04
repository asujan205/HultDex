const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("HultDex", function () {
  let HultDex;
  let Owner;
  let addr1;

  const initialBalance = ethers.utils.parseEther("100");

  beforeEach(async function () {
    [Owner, addr1] = await ethers.getSigners();
    HultDex = await ethers.getContractFactory("HultDex");
    HultDex = await HultDex.deploy();
  });
});
