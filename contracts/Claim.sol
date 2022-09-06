// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./NFT.sol";

contract Claim {
    address nftContract;

    constructor(address _nftContract) {
        nftContract = _nftContract;
    }

    function claim(uint256 token, string memory name) public {
        NFT nft = NFT(nftContract);
        nft.claim(msg.sender, token, name);
    }
}
