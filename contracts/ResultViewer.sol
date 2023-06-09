// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IPFSStorage.sol";
import "./PrivateKeyVerifier.sol";

contract ResultViewer {
    IPFSStorage private ipfsStorage;
    PrivateKeyVerifier private privateKeyVerifier;

    constructor(address _ipfsStorage, address _privateKeyVerifier) {
        ipfsStorage = IPFSStorage(_ipfsStorage);
        privateKeyVerifier = PrivateKeyVerifier(_privateKeyVerifier);
    }

    function getResultDocument(
        bytes32 privateKey
    ) external view returns (string memory) {
        require(
            privateKeyVerifier.verifyPrivateKey(msg.sender, privateKey),
            "Invalid private key"
        );

        return ipfsStorage.getDocument();
    }
}
