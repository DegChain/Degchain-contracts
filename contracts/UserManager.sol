// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

//errors
error UserManager__InvalidDOB(bytes32 rollNumber, bytes32 DOB);
error UserManager__InvalidPrivateKey(address accountAddress);
error UserManager__InvalidPassword(string emailId, string password);

/**
 * @title UserManager
 * @author Vivek Upadhyay
 * @notice A contract to register and login users
 */
contract UserManager {
    //events
    event UserRegistered(bytes32 indexed rollNumber, bytes32 DOB);
    event UserLoggedIn(address accountAddress);
    struct User {
        bytes32 rollNumber;
        bytes32 dateOfBirth;
        address accountAddress;
    }
    struct Admin {
        string emailId;
        address account;
    }

    //variables
    string private constant PASSWORD = "something_else";
    mapping(bytes32 => bytes32) private rollNumberToDOB;
    mapping(address => User) private users;
    Admin[] private admins;

    //storing the DateOfBirths
    //IMP -  consider the huge amount of data we are storing in the mapping won't
    //it increase the cost of deployment of the contract
    //how to optimize it

    //Regsiter a new user
    function registerUser(bytes32 DOB, bytes32 rollNumber) external {
        if (
            rollNumberToDOB[rollNumber] != DOB
        ) //we already have data for all students
        {
            revert UserManager__InvalidDOB(rollNumber, DOB);
        }
        //we need to connect to a wallet in order to have a users address
        //since we can't by ourselves generate a address, as we also need to manage it on a blockchain
        User memory newUser = User({
            rollNumber: rollNumber,
            dateOfBirth: DOB,
            accountAddress: msg.sender //this is good as register button is used by the user hence sender would be the User only
        });
        users[msg.sender] = newUser;
        emit UserRegistered(rollNumber, DOB);
    }

    //Login a User by verifying their private key
    function loginUser() external returns (bool result) {
        if (users[msg.sender].rollNumber == "") {
            return false; //I think msg.sender is good here
        }
        return true;
    }

    //get a particular user details
    function getUser(address UserAddress) external view returns (User memory) {
        if (users[UserAddress].rollNumber == "") {
            revert UserManager__InvalidPrivateKey(UserAddress); //I need to make this statement more intuitive
        }
        return users[UserAddress];
    }

    //Register a new Admin
    function registerAdmin(
        string memory emailId,
        string memory password
    ) public {
        if (keccak256(bytes(password)) != keccak256(bytes(PASSWORD))) {
            //comparing the hash values of two functions
            revert UserManager__InvalidPassword(emailId, password);
        }
        Admin memory newAdmin = Admin({emailId: emailId, account: msg.sender});
        admins.push(newAdmin);
    }

    // Login Admin
    function loginAdmin() external returns (bool result) {
        for (uint256 i = 0; i < admins.length; i++) {
            if (admins[i].account == msg.sender) {
                return true; // Admin found
            }
        }
        return false; // Admin not found
    }
}
