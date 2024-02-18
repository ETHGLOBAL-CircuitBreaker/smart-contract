// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ZKEmailLinkhub {
    address public owner;

    // Mapping to store user assets
    mapping(address => uint256) public userAssets;

    event Swap(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Function to deposit assets into the contract
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        userAssets[msg.sender] += msg.value;
        emit Swap(msg.sender, msg.value);
    }

    // Function to withdraw assets from the contract
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdraw amount must be greater than 0");
        require(amount <= userAssets[msg.sender], "Insufficient balance");
        userAssets[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Swap(msg.sender, amount);
    }

    // Function to swap assets between users
    function swap(address to, uint256 amount) external {
        require(to != address(0), "Invalid recipient address");
        require(amount > 0, "Swap amount must be greater than 0");
        require(amount <= userAssets[msg.sender], "Insufficient balance");

        // Transfer assets from sender to recipient
        userAssets[msg.sender] -= amount;
        userAssets[to] += amount;

        emit Swap(msg.sender, amount);
        emit Swap(to, amount);
    }
}
