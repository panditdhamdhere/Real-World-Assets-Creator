// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {ConfirmedOwner} from "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";

/**
 * @title dTSLA
 * @author Pandit Dhamdhere
 * @notice
 */

contract dTSLA {
    /// Send an HTTP request to:
    // 1. How much TSLA is bought
    // 2. If enough TSLA is in the alpaca account,
    // mint dTSLA

    // Transaction function
    function sendMintRequest(uint256 amount) external onlyOwner {}

    function _mintFulFillRequest() internal {}

    /// @notice USER sends a request to sell TSLA for USDC or (Redemption token )
    // This , have the chainlink function call our alpaca(bank)
    /// and do the following:
    // 1. Sell TSLA on the brokerage
    // 2. Buy USDC on the brokerage
    // 3. Send USDC to this contract for the user to withdraw

    function sendRedeemRequest() external {}

    function _redeemFulFillRequest() internal {}
}
