// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/FunctionsClient.sol";
import {ConfirmedOwner} from "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";
import {FunctionsRequest} from "@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/libraries/FunctionsRequest.sol";

/**
 * @title dTSLA
 * @author Pandit Dhamdhere
 * @notice
 */

contract dTSLA is ConfirmedOwner, FunctionsClient {
    using FunctionsRequest for FunctionsRequest.Request;

    enum MintOrRedeem {
        mint,
        redeem
    }

    struct dTslaRequest {
        uint256 amountOfToken;
        address requester;
        MintOrRedeem mintOrRedeem;
    }

    address constant SEPOLIA_FUNCTIONS_ROUTER =
        0xb83E47C2bC239B3bf370bc41e1459A34b41238D0;
    uint32 constant GAS_LIMIT = 300_000;
    bytes32 constant DON_ID =
        hex"66756e2d657468657265756d2d7365706f6c69612d3100000000000000000000";
    uint64 immutable i_subId;
    string private s_mintSourceCode;
    mapping(bytes32 requestId => dTslaRequest request)
        private s_requestIdToRequest;

    constructor(
        string memory mintSourceCode,
        uint64 subId
    ) ConfirmedOwner(msg.sender) FunctionsClient(SEPOLIA_FUNCTIONS_ROUTER) {
        s_mintSourceCode = mintSourceCode;
        i_subId = subId;
    }

    /// Send an HTTP request to:
    // 1. How much TSLA is bought
    // 2. If enough TSLA is in the alpaca account,
    // mint dTSLA

    // Transaction function
    function sendMintRequest(
        uint256 amount
    ) external onlyOwner returns (bytes32) {
        FunctionsRequest.Request memory req;
        req.initializeRequestForInlineJavaScript(s_mintSourceCode);
        bytes32 requestId = _sendRequest(
            req.encodeCBOR(),
            i_subId,
            GAS_LIMIT,
            DON_ID
        );
        s_requestIdToRequest[requestId] = dTslaRequest(
            amount,
            msg.sender,
            MintOrRedeem.mint
        );
        return requestId;
    }

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
