
# TimeLockedWallet Smart Contract

## Overview
The `TimeLockedWallet` contract allows funds to be securely stored and released only after a specified time. This is particularly useful for scenarios such as vesting schedules, time-based payouts, and deferred payments. The contract is initialized with a **beneficiary** address and a **release time**, after which only the beneficiary can withdraw the funds.

## Features
- **Time-Locked Withdrawal**: Funds can only be withdrawn by the beneficiary after a predetermined release time.
- **Secure Deposits**: Anyone can deposit funds into the contract.
- **Automatic Notifications**: The contract emits events for deposits and withdrawals, making it easy to track activity.
- **Read-Only Functions**: Users can view the current balance and the time remaining until funds can be withdrawn.

---

## Contract Functions

### `constructor(address _beneficiary, uint256 _releaseTime)`
- **Description**: Initializes the contract by setting the beneficiary and release time.
- **Parameters**:
  - `_beneficiary` (address): The address of the beneficiary who will receive the funds.
  - `_releaseTime` (uint256): The timestamp after which funds can be withdrawn.
- **Requirements**:
  - The `_releaseTime` must be a future timestamp.
- **Effects**:
  - Sets the beneficiary and release time upon deployment.
- **Returns**: None.

### `receive`
- **Description**: Fallback function to receive and store ETH sent to the contract.
- **Emits**:
  - `Deposited(address indexed sender, uint256 amount, uint256 time)`: Logs the sender address, deposit amount, and timestamp.
- **Returns**: None.

### `withdraw`
- **Description**: Withdraws the entire balance of the contract to the beneficiary.
- **Requirements**:
  - The current timestamp must be greater than or equal to the `releaseTime`.
  - Only the `beneficiary` can call this function.
  - The contract must have a non-zero balance.
- **Effects**:
  - Transfers all ETH in the contract to the beneficiary.
  - Emits the `Withdrawn` event.
- **Emits**:
  - `Withdrawn(address indexed beneficiary, uint256 amount)`: Logs the beneficiary address and the withdrawn amount.
- **Returns**: None.

### `getBalance`
- **Description**: Returns the current ETH balance of the contract.
- **Parameters**: None.
- **Returns**: 
  - `uint256`: The balance of the contract in wei.

### `timeUntilRelease`
- **Description**: Returns the remaining time until the funds can be withdrawn.
- **Parameters**: None.
- **Returns**: 
  - `uint256`: The number of seconds remaining until the release time. If the release time has passed, returns `0`.

---

## Contract Variables

### `beneficiary`
- **Type**: `address`
- **Description**: The address of the beneficiary who will receive the funds when the time lock expires.

### `releaseTime`
- **Type**: `uint256`
- **Description**: The timestamp when the funds will be released and available for withdrawal.

---

## Events

### `Deposited`
- **Emitted When**: Ether is deposited into the contract.
- **Parameters**:
  - `sender` (address): The address of the sender who deposited funds.
  - `amount` (uint256): The amount of Ether deposited.
  - `time` (uint256): The timestamp of the deposit.

### `Withdrawn`
- **Emitted When**: The beneficiary successfully withdraws funds from the contract.
- **Parameters**:
  - `beneficiary` (address): The address of the beneficiary who withdrew the funds.
  - `amount` (uint256): The amount of Ether withdrawn.

---

## Security Considerations
- **Time Manipulation**: The release time is set once during contract deployment and cannot be changed, reducing the risk of time-based attacks.
- **Beneficiary Control**: Only the beneficiary can withdraw the funds, ensuring that unauthorized parties cannot access the funds.
- **No Reentrancy Protection**: The contract does not include reentrancy protection (`nonReentrant` modifier) as the withdrawal transfers are straightforward. However, consider adding this modifier for more complex versions.

---

## Deployment
- **Network Compatibility**: Can be deployed on any Ethereum-compatible network.
- **Initial Parameters**:
  - `beneficiary` address should be set to the address of the intended recipient.
  - `releaseTime` should be set to a future Unix timestamp.
- **Gas Optimization**: The contract has minimal operations, making it gas-efficient.

---

## Usage Example
1. **Deploy the Contract**:
   - Specify the beneficiary address and the desired release timestamp.
2. **Deposit Funds**:
   - Send ETH directly to the contract address.
3. **Check Remaining Time**:
   - Use `timeUntilRelease()` to see how much time is left until withdrawal is allowed.
4. **Withdraw Funds**:
   - Once the release time has passed, the beneficiary can call `withdraw()` to receive the funds.

---

## License
This contract is licensed under the **MIT License**.
