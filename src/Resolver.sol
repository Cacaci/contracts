// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";

address constant _bebContract = 0x0F08FC2A63F4BfcDDfDa5c38e9896220d5468a64;

contract Resolver {
    mapping (uint256 => string) map;

    function set(uint256 tokenId, string memory _value) external {
        IERC721 beb = IERC721(_bebContract);

        if (beb.ownerOf(tokenId) == msg.sender) {
            map[tokenId] = _value;
        }
    }

    function get(uint256 tokenId) external view returns (string memory) {
        return map[tokenId];
    }
}
