// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";


contract FragPass is ERC721A, Ownable {
    bytes32 public root;
    mapping(address => bool) public alreadyClaimed;

    event AccountClaimed(address account);

    constructor(bytes32 _root) ERC721A("FragPass", "F-PASS") {
        root = _root;
    }

    function safeMint(bytes32[] memory _proof) public payable {
        require(!alreadyClaimed[msg.sender], "Account has already claimed");
        require(MerkleProof.verify(_proof, root, _leaf), "Account is not a part of the Whitelist");

        _safeMint(msg.sender, 1);
        alreadyClaimed[msg.sender] = true;

        emit AccountClaimed(msg.sender);
    }
}
