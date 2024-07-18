// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract Pandit is ERC20, ERC20Permit {
    constructor() ERC20("Pandit", "PDT") ERC20Permit("Pandit") {}

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    function mint() public {
        _mint(msg.sender, 1e6);
    }
}
