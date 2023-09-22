// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "forge-std/Test.sol";
import "../src/Resolver.sol";

contract MockBeb is ERC721 {
    constructor() ERC721("MockBeb", "MB") {}

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
}

contract ResolverTest is Test {
    Resolver public resolver;
    address bob = address(0x1);
    address alice = address(0x2);
    MockBeb public beb;

    function setUp() public {
        resolver = new Resolver();
        beb = new MockBeb();
        resolver.transferOwnership(bob);
        vm.startPrank(bob);
        resolver.setBebContract(address(beb));
        beb.mint(address(bob), 1);
        beb.mint(address(alice), 2);
        vm.stopPrank();
    }

    function testOnlyOwnerCanSetBebContract() public {
        vm.startPrank(alice);
        vm.expectRevert("only owner can set beb contract");
        resolver.setBebContract(address(0x1));
        assertTrue(resolver.getBebContract() == address(beb));
        vm.stopPrank();
        vm.startPrank(bob);
        resolver.setBebContract(address(0x123));
        assertTrue(resolver.getBebContract() == address(0x123));
    }

    function testOnlyOwnerCanSetFallbackUrl() public {
        vm.startPrank(alice);
        vm.expectRevert("only owner can set fallback url");
        resolver.setFallbackUrl("https://alice.com");
        assertTrue(keccak256(bytes(resolver.getFallbackUrl())) == keccak256(bytes("https://protocol.cast.quest/graphql")));
        vm.stopPrank();
        vm.startPrank(bob);
        resolver.setFallbackUrl("https://bob.com");
        assertTrue(keccak256(bytes(resolver.getFallbackUrl())) == keccak256(bytes("https://bob.com")));
    }

    function testOnlyOwnerCanSet() public {
        vm.startPrank(alice);
        vm.expectRevert("only owner of tokenId can set");
        resolver.set(1, "https://alice.com");
        assertTrue(keccak256(bytes(resolver.get(1))) == keccak256(bytes("https://protocol.cast.quest/graphql")));
    }

    function testSet() public {
        vm.startPrank(bob);
        resolver.set(1, "https://bob.com");
        assertTrue(keccak256(bytes(resolver.get(1))) == keccak256(bytes("https://bob.com")));
    }
}
