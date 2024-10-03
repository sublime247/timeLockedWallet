// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const beneficiary = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
const JAN_1ST_2030 = 1893456000;    
const TimeLockedWalletModule = buildModule("TimeLockedWalletModule", (m) => {


  const timeLocked = m.contract("TimeLockedWallet", [beneficiary, JAN_1ST_2030]);

  return { timeLocked };
});

export default TimeLockedWalletModule;
