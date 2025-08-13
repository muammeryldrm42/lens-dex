const fs = require("fs");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with:", deployer.address);

  const Token = await ethers.getContractFactory("ERC20Token");
  const tokenA = await Token.deploy("TokenA", "TKA", ethers.utils.parseEther("1000000"));
  const tokenB = await Token.deploy("TokenB", "TKB", ethers.utils.parseEther("1000000"));
  await tokenA.deployed();
  await tokenB.deployed();

  console.log("TokenA:", tokenA.address);
  console.log("TokenB:", tokenB.address);

  const Dex = await ethers.getContractFactory("Dex");
  const dex = await Dex.deploy(tokenA.address, tokenB.address);
  await dex.deployed();

  console.log("DEX:", dex.address);

  const contractsData = {
    tokenA: tokenA.address,
    tokenB: tokenB.address,
    dex: dex.address
  };
  fs.writeFileSync("./frontend/src/contracts.json", JSON.stringify(contractsData, null, 2));
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
