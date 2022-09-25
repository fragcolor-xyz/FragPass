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
        require(isValid(_proof, keccak256(abi.encodePacked(msg.sender))), "Account is not a part of the Whitelist");

        _safeMint(msg.sender, 1);
        alreadyClaimed[msg.sender] = true;

        emit AccountClaimed(msg.sender);
    }

    function isValid(bytes32[] memory _proof, bytes32 leaf) public view returns (bool) {
        return MerkleProof.verify(_proof, root, _leaf);
    }
}
