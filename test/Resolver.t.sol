// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "forge-std/Test.sol";
import "../src/Resolver.sol";

contract ResolverTest is Test {
    Resolver public resolver;
    address bob = address(0x1);
    address alice = address(0x2);

    function setUp() public {
        resolver = new Resolver();
        resolver.transferOwnership(bob);
    }

    function testOnlyOwnerCanSetBebContract() public {
        vm.startPrank(alice);
        vm.expectRevert("only owner can set beb contract");
        resolver.setBebContract(address(0x1));
        assertTrue(resolver.getBebContract() == address(0x0F08FC2A63F4BfcDDfDa5c38e9896220d5468a64));
        vm.stopPrank();
        vm.startPrank(bob);
        resolver.setBebContract(address(0x123));
        assertTrue(resolver.getBebContract() == address(0x123));
    }

    function testOnlyOwnerCanSetFallbackUrl() public {
        vm.startPrank(alice);
        vm.expectRevert("only owner can set fallback url");
        resolver.setFallbackUrl("https://alice.com");
        assertTrue(keccak256(bytes(resolver.getFallbackUrl())) == keccak256(bytes("https://protocol.beb.xyz/graphql")));
        vm.stopPrank();
        vm.startPrank(bob);
        resolver.setFallbackUrl("https://bob.com");
        assertTrue(keccak256(bytes(resolver.getFallbackUrl())) == keccak256(bytes("https://bob.com")));
    }
}
