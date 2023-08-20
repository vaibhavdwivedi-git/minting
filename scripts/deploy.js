const hre = require("hardhat");

async function main() {
  const acradeCats = await hre.ethers.deployContract("ArcadeCats");
  await acradeCats.waitForDeployment();

  console.log("Token deployed to:", acradeCats.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
