const fs = require('fs');
const ethers = require('ethers');

const mnemonic = fs.readFileSync(`${process.cwd()}/credentials/internal.txt`, { encoding: 'utf8' }).toString();

const hdnode = ethers.utils.HDNode.fromMnemonic(mnemonic);

const counts = 3;

function getAccounts(count) {
  let accounts = [];
  for (let i = 0; i < count; i += 1) {
    const acc = hdnode.derivePath(`m/44'/60'/0'/0/${i}`);
    accounts.push({ address: acc.address, privateKey: acc.privateKey, index: acc.index });
  }
  return accounts;
}

// write account.json file to local configs
function writeAccountConfigs(num) {
  fs.writeFileSync(`${process.cwd()}/configs/accounts.json`, JSON.stringify(getAccounts(num)));
}

writeAccountConfigs(counts);

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: '0.8.12',
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000,
      },
    },
  },
  sources: './contracts',
  artifacts: './artifacts',
  networks: {
    hardhat: {
      // url: 'http://127.0.0.1:8545',
      accounts: {
        mnemonic,
        path: "m/44'/60'/0'/0",
        initialIndex: 0,
        count: counts,
        passphrase: '',
      },
    },
  },
};
