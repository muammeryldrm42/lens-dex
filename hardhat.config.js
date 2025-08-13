hardhat.config.js
require("@nomiclabs/hardhat-ethers");

module.exports = {
  solidity: "0.8.18",
  networks: {
    lensTestnet: {
      url: "https://rpc.testnet.lens.xyz",
      chainId: 37111,
      accounts: ["0xf33350b3778985a606468906908eb002644c2d59"] // testnet cüzdan private key
    }
  }
};
