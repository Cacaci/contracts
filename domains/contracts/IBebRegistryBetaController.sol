/////////
// Wield
// https://wield.co
// SPDX-License-Identifier: UNLICENSED
/////////

pragma solidity >=0.8.4;

import "./IPriceOracle.sol";

interface IBebRegistryBetaController {
    function rentPrice(string memory, uint256)
        external
        returns (IPriceOracle.Price memory);

    function available(string memory) external returns (bool);

    function makeCommitment(
        string memory,
        address,
        uint256,
        bytes32
    ) external returns (bytes32);

    function commit(bytes32) external;

    function register(
        string calldata,
        address,
        uint256,
        bytes32
    ) external payable;

    function renew(string calldata, uint256) external payable;
}
