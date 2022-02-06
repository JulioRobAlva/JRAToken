// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <=0.8.11;

import "https://github.com/JulioRobAlva/JRAToken/blob/main/ERC20JRA.sol";

contract JRAToken is ERC20 {
    constructor() ERC20("JulioRobAlva", "JRA") {
        _mint(msg.sender , 21000000 ether);
        
        }
    }