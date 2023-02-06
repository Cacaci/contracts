// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Resolver.sol";

contract ResolverTest is Test {
    Resolver public resolver;

    function setUp() public {
        resolver = new Resolver();
        resolver.set(0, "hello");
    }

    // function testIncrement() public {
    //     resolver.increment();
    //     assertEq(resolver.number(), 1);
    // }

    // function testSetNumber(uint256 x) public {
    //     resolver.setNumber(x);
    //     assertEq(resolver.number(), x);
    // }
}
