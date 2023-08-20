const { expect } = require("chai");
const ethers = require("hardhat");

describe("myNFT", function () {
  it("Should mint and transfer an NFT to a valid address", async function () {
    const acradeCats = await hre.ethers.deployContract("ArcadeCats");
    await acradeCats.waitForDeployment();

    const recipient = "0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199";
    const metadataURI = "QmWWTdhvY3g493K15a5VjSTTnaxmDPf1jsLt4iJigzD71E";

    let balance = await acradeCats.balanceOf(recipient);

    expect(balance).to.equal(0);

    const newlyMintedToken = await acradeCats.payToMint(
      recipient,
      metadataURI,
      { value: hre.ethers.parseEther("0.51") }
    );

    balance = await acradeCats.balanceOf(recipient);

    expect(balance).to.equal(1);
    expect(await acradeCats.isOwned(metadataURI)).to.equal(true);
  });
});
