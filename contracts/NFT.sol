// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract NFT is ERC721, IERC721Receiver {
    uint256 counter = 0;

    address claimContract;

    mapping(uint256 => string) public names;
    mapping(uint256 => bool) public claimed;

    constructor() ERC721("ClaimNFT", "CLNFT") {}

    function approvalClaimContract(address _claimContract) public {
        _setApprovalForAll(address(this), _claimContract, true);
    }

    function premint(uint256 quantity) public {
        for (uint256 i = 0; i < quantity; i++) {
            _safeMint(address(this), counter);
            counter++;
        }
    }

    function claim(
        address to,
        uint256 token,
        string memory name
    ) public {
        require(claimed[token] == false, "This token has already been claimed");

        names[token] = name;
        claimed[token] = true;

        safeTransferFrom(address(this), to, token);
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }
}
