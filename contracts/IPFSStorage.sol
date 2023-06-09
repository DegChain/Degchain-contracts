// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "ipfs-http-client/declarations.sol";

contract IPFSStorage is Ownable {
    struct Document {
        string ipfsHash;
        bool exists;
    }

    mapping(address => Document) private documents;

    event DocumentUploaded(address indexed user, string ipfsHash);

    function uploadDocument(string memory _ipfsHash) external onlyOwner {
        require(
            documents[msg.sender].exists == false,
            "Document already uploaded"
        );

        documents[msg.sender] = Document(_ipfsHash, true);
        emit DocumentUploaded(msg.sender, _ipfsHash);
    }

    function getDocument() external view returns (string memory) {
        require(documents[msg.sender].exists, "Document not found");

        return documents[msg.sender].ipfsHash;
    }
}
