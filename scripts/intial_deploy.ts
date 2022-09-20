// import '@nomiclabs/hardhat-ethers';
import hre from 'hardhat';
// import { signers } from './setting';
import fs from 'fs';
import { create2, numberToBytes32Hex } from './utils';
// import { create2, numberToBytes32Hex } from './utils';
// import { Interface } from 'ethers/lib/utils';
const { ethers } = hre;

async function main() {
  // const greatDeployer = new ethers.Wallet(signers[0].privateKey);
  // const account_sponsor = new ethers.Wallet(signers[1].privateKey);
  const contractDeloyedInfoJson = JSON.parse(fs.readFileSync(`${process.cwd()}/configs/deployed.json`, { encoding: 'utf8' }));

  let entryPointAddress: string | undefined;

  const [owner, account1] = await ethers.getSigners();
  const maybeAddress: string | undefined = contractDeloyedInfoJson.entryPointAddress;
  let isDeployed = false;

  const singleton = await ethers.getContractFactory('contracts/SingletonFactory.sol:SingletonFactory', owner);
  let Create2FactoryContractAddress: string | undefined;
  if (!Create2FactoryContractAddress) {
    const Create2FactoryContract = await singleton.deploy();
    const deployed = await Create2FactoryContract.deployed();

    Create2FactoryContractAddress = Create2FactoryContract.address;

    console.log(await deployed.provider.getCode(Create2FactoryContractAddress));
    //   const deployedSingleton = await singleton.deploy();
    // console.log(await provider.getCode(Create2FactoryContractAddress));
  }

  // if (maybeAddress) {
  //   isDeployed = true;
  // }

  if (!isDeployed) {
    console.log({ Create2FactoryContractAddress });
    const entryPoint = await ethers.getContractFactory('contracts/EntryPoint.sol:EntryPoint');
    const entryPointCreateSalt = 0;
    const entryPointArgs = [
      Create2FactoryContractAddress!, // address _create2factory
      ethers.utils.parseUnits('0.001', 'ether'), // uint256 _paymasterStake
      60,
    ];
    const entryPointBytecode = entryPoint.interface.encodeDeploy(entryPointArgs);

    entryPointAddress = create2(Create2FactoryContractAddress!, entryPointCreateSalt, entryPointBytecode);
    console.log({ entryPointAddress });

    //   // console.log(singleton.interface);
    if ((await ethers.provider.getCode(entryPointAddress)) === '0x') {
      const singletonArgs = [entryPointBytecode, numberToBytes32Hex(entryPointCreateSalt)];
      const callData = singleton.interface.encodeFunctionData('deploy', singletonArgs);

      const tx = await account1.sendTransaction({
        to: Create2FactoryContractAddress,
        value: '0x00',
        data: callData,
        gasLimit: ethers.utils.parseUnits('1000000', 'wei'),
        // gasLimit: ethers.utils.parseUnits('2750000000000000000000000000', 'wei'),
      });
      console.log({ tx });
      // const deployedEntryPoint = await entryPoint.deploy(...entryPointArgs);
      // const receipt = await provider.waitForTransaction(tx.hash, 10, 3000);
      const receipt = await tx.wait(1);
      if (receipt) {
        console.log(receipt);

        console.log(await ethers.provider.getCode(Create2FactoryContractAddress!));
        console.log(await ethers.provider.getCode(entryPointAddress!));

        fs.writeFileSync(`${process.cwd()}/configs/deployed.json`, JSON.stringify({ entryPointAddress }));
      }

      // entryPointAddress = deployedEntryPoint.address;
    }
  }

  //   test('connect provider', async () => {
  //     console.log(await provider.getNetwork());
  //     console.log('===== deployer info ====');
  //     greatDeployer.connect(provider);
  //     console.log(await greatDeployer.getAddress());
  //     const deployerBalance = (await provider.getBalance(await greatDeployer.getAddress())).toBigInt();
  //     console.log(ethers.utils.formatEther(deployerBalance) + ' ETH');

  //     console.log('===== sponsor info ====');
  //     account_sponsor.connect(provider);
  //     console.log(await account_sponsor.getAddress());
  //     const sponsorBalance = (await provider.getBalance(await account_sponsor.getAddress())).toBigInt();
  //     console.log(ethers.utils.formatEther(sponsorBalance) + ' ETH');
  //   });

  // test('deploy entrypoint', async () => {

  // if (maybeAddress) {
  //   isDeployed = true;
  // }

  // if (!isDeployed) {
  //   console.log({ Create2FactoryContractAddress });
  //   const entryPoint = await ethers.getContractFactory('contracts/EntryPoint.sol:EntryPoint');
  //   const entryPointCreateSalt = 0;
  //   const entryPointArgs = [
  //     Create2FactoryContractAddress!, // address _create2factory
  //     ethers.utils.parseUnits('0.001', 'ether'), // uint256 _paymasterStake
  //     60,
  //   ];
  //   const entryPointBytecode = entryPoint.interface.encodeDeploy(entryPointArgs);

  //   entryPointAddress = create2(Create2FactoryContractAddress!, entryPointCreateSalt, entryPointBytecode);
  //   console.log({ entryPointAddress });

  //   //   // console.log(singleton.interface);
  //   if ((await provider.getCode(entryPointAddress)) === '0x') {
  //     const singletonArgs = [entryPointBytecode, numberToBytes32Hex(entryPointCreateSalt)];
  //     const callData = singleton.interface.encodeFunctionData('deploy', singletonArgs);

  //     const tx = await account1.sendTransaction({
  //       to: Create2FactoryContractAddress,
  //       value: '0x00',
  //       data: callData,
  //       gasLimit: ethers.utils.parseUnits('1000000', 'wei'),
  //       // gasLimit: ethers.utils.parseUnits('2750000000000000000000000000', 'wei'),
  //     });
  //     console.log({ tx });
  //     // const deployedEntryPoint = await entryPoint.deploy(...entryPointArgs);
  //     // const receipt = await provider.waitForTransaction(tx.hash, 10, 3000);
  //     const receipt = await tx.wait(1);
  //     if (receipt) {
  //       console.log(receipt);

  //       console.log(await provider.getCode(Create2FactoryContractAddress!));
  //       console.log(await provider.getCode(entryPointAddress!));

  //       fs.writeFileSync(`${process.cwd()}/configs/deployed.json`, JSON.stringify({ entryPointAddress }));
  //     }

  //     // entryPointAddress = deployedEntryPoint.address;
  //   }
  // }
  // });
}

main().catch(error => {
  console.error(error);
  process.exitCode = 1;
});
