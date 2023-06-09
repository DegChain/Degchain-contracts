// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Authentication {
    mapping(address => bool) private authenticatedUsers;

    event UserAuthenticated(address indexed user);

    function authenticate() external {
        require(
            authenticatedUsers[msg.sender] == false,
            "User already authenticated"
        );

        authenticatedUsers[msg.sender] = true;
        emit UserAuthenticated(msg.sender);
    }

    function isAuthenticated() external view returns (bool) {
        return authenticatedUsers[msg.sender];
    }
}
