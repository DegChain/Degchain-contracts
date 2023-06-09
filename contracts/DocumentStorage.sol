// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract DocumentStorage {
    //structure to represent a Document
    struct Document {
        uint256 id;
        address owner;
        string ipfsHash;
    }
    //mapping to store documents by user
    mapping(address => Document[]) private userDocuments;
    uint256 private documentIdCounter; //unique to each document

    function uploadDocument(string calldata ipfsHash) external {
        require(bytes(ipfsHash).length > 0, "IPFS Hash cannot be empty.");
        Document memory newDocument = Document({
            id: documentIdCounter,
            owner: msg.sender,
            ipfsHash: ipfsHash
        })
        //add the new doc in the mapping
        userDocuments[msg.sender].push(newDocument);
        documentIdCounter++;
    }
    function getUserDocuments() external view returns (Document[] memory)
    {
        return userDocuments[msg.sender]; //rather than using userDocuments[userAddress]
    }
}
