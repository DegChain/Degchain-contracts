// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract UserRegistry is Ownable {
    struct User {
        bytes32 rollNumber;
        address account;
    }

    mapping(address => User) private users;

    event UserRegistered(address indexed user, bytes32 rollNumber);
    event UserAccountAssociated(address indexed user, bytes32 rollNumber);

    /**
     *
     * @param _rollNumber used to identify unique students
     */
    function registerUser(bytes32 _rollNumber) external {
        require(
            users[msg.sender].account == address(0),
            "User already registered"
        );

        users[msg.sender] = User(_rollNumber, msg.sender);
        emit UserRegistered(msg.sender, _rollNumber);
    }

    function associateAccount(bytes32 _rollNumber) external onlyOwner {
        require(
            users[msg.sender].account == address(0),
            "User account already associated"
        );

        users[msg.sender].rollNumber = _rollNumber;
        emit UserAccountAssociated(msg.sender, _rollNumber);
    }

    function getUserRollNumber() external view returns (bytes32) {
        require(users[msg.sender].account != address(0), "User not registered");

        return users[msg.sender].rollNumber;
    }
}
