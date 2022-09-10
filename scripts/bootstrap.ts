import shell from 'shelljs';

async function runHardhat() {
  shell.exec('npx hardhat node');
}

runHardhat();
