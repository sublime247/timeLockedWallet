// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimeLockedWallet {
    address public beneficiary; // Address of the beneficiary who will receive funds
    uint256 public releaseTime; // Timestamp when the funds can be withdrawn

    // Event to notify when funds are deposited
    event Deposited(address indexed sender, uint256 amount, uint256 time);
    // Event to notify when funds are withdrawn
    event Withdrawn(address indexed beneficiary, uint256 amount);

    // Constructor to set the beneficiary and release time upon contract deployment
    constructor(address _beneficiary, uint256 _releaseTime) {
        require(
            _releaseTime > block.timestamp,
            "Release time should be in the future"
        );
        beneficiary = _beneficiary;
        releaseTime = _releaseTime;
    }

    // Fallback function to accept incoming payments
    receive() external payable {
        emit Deposited(msg.sender, msg.value, block.timestamp);
    }

    // Function to withdraw the funds if the time lock has expired
    function withdraw() public {
        require(
            block.timestamp >= releaseTime,
            "Current time is before release time"
        );
        require(
            msg.sender == beneficiary,
            "Only the beneficiary can withdraw the funds"
        );

        uint256 amount = address(this).balance;
        require(amount > 0, "No funds to withdraw");

        payable(beneficiary).transfer(amount);
        emit Withdrawn(beneficiary, amount);
    }

    // Function to get the current balance of the contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Function to get the remaining time until funds can be withdrawn
    function timeUntilRelease() public view returns (uint256) {
        if (block.timestamp >= releaseTime) {
            return 0;
        } else {
            return releaseTime - block.timestamp;
        }
    }
}
