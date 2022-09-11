import ethers from 'ethers';
import accounts from '../configs/accounts.json';
import EntryPointContract from '../artifacts/contracts/EntryPoint.sol/EntryPoint.json';
import fs from 'fs';

export const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');
export const signers = accounts.map(e => e);
export const EntryPoint = EntryPointContract;
export const AddressZero = '0x0000000000000000000000000000000000000000';

// /**
//  * entry point contract address. singleton contract.(test address)
//  */
// export const EntryPointAddress = '0x5eb364f6bA9aC8d43D90540Bf319a3feeE59A1c8';

// export const PayMasterAddress = '0xEaef8AE7d2A7Ff527F37083091C5C90F358158d9';

/**
 * create2factory address defined in eip-2470.
 */
export const Create2Factory = '0xce0042B868300000d44A59004Da54A005ffdcf9f';

// export const singletonFactoryJson = JSON.parse(fs.readFileSync(`${process.cwd()}/artifacts/abi/singletonFactory.json`, { encoding: 'utf8' }));
