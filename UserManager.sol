pragma solidity ^0.8.0;

contract UserManager {
    struct User {
        string rollNumber;
        bytes32 dateOfBirth;
        address account;
        bool isAdmin;
    }

    mapping(string => bytes32) private rollNumberToDob;
    mapping(address => User) private users;

    // Register a new user with the given roll number and date of birth
    function registerUser(string calldata rollNumber, bytes32 dob) external {
        require(
            rollNumberToDob[rollNumber] == 0,
            "User with the provided roll number already exists"
        );

        // Store the roll number and date of birth mapping for verification
        rollNumberToDob[rollNumber] = dob;

        // Create a new User struct and store it with the user's address
        User memory newUser = User({
            rollNumber: rollNumber,
            dateOfBirth: dob,
            account: msg.sender,
            isAdmin: false
        });
        users[msg.sender] = newUser;
    }

    // Login a user by verifying their roll number and date of birth
    function loginUser(
        string calldata rollNumber,
        bytes32 dob
    ) external view returns (bool) {
        bytes32 storedDob = rollNumberToDob[rollNumber];
        require(
            storedDob != 0 && storedDob == dob,
            "Invalid roll number or date of birth"
        );
        return true;
    }

    // Get the user details for a given address
    function getUser(address userAddress) external view returns (User memory) {
        return users[userAddress];
    }

    // Check if the user is an admin
    function isAdmin(address userAddress) external view returns (bool) {
        return users[userAddress].isAdmin;
    }

    // Set the admin status for a user
    function setAdminStatus(address userAddress, bool isAdminStatus) external {
        require(
            msg.sender == userAddress,
            "Only the user can update their admin status"
        );
        users[userAddress].isAdmin = isAdminStatus;
    }
}
