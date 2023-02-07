// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Resolver.sol";

contract ResolverTest is Test {
    Resolver public resolver;

    function setUp() public {
        resolver = new Resolver();
        resolver.set(0, "hello");
    }
}
