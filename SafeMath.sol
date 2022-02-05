// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <=0.8.11;

/**
 Arithmetic operations in Solidity wrap on overflow. 
 `SafeMath` restores this intuition by reverting the transaction when an operation overflows.
 */
library SafeMath {

    /**
     Returns the addition of two unsigned integers, with an overflow flag.
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }

    /**
     Returns the substraction of two unsigned integers, with an overflow flag.
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b > a) return (false, 0);
        return (true, a - b);
    }

    /**
     Returns the multiplication of two unsigned integers, with an overflow flag.
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {

        if (a == 0) return (true, 0);
        uint256 c = a * b;
        if (c / a != b) return (false, 0);
        return (true, c);
    }

    /**
     Returns the division of two unsigned integers, with a division by zero flag.
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a / b);
    }

    /**
     Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a % b);
    }

    /**
     Returns the addition of two unsigned integers, reverting on overflow.
     Counterpart to Solidity's `+` operator.
     - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    /**
     Returns the subtraction of two unsigned integers, reverting on overflow (when the result is negative).
     Counterpart to Solidity's `-` operator.
     - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }

    /**
     Returns the multiplication of two unsigned integers, reverting on overflow.
     Counterpart to Solidity's `*` operator.
     - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    /**
     Returns the integer division of two unsigned integers, reverting on division by zero. The result is rounded towards zero.
     this function uses a `revert` opcode (which leaves remaining gas untouched) while Solidity
     uses an invalid opcode to revert (consuming all remaining gas).
     - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        return a / b;
    }

    /**
     Returns the remainder of dividing two unsigned integers. (unsigned integer modulo), reverting when dividing by zero.
     Counterpart to Solidity's `%` operator. This function uses a `revert` opcode (which leaves remaining gas untouched) while Solidity uses an
     invalid opcode to revert (consuming all remaining gas).
     - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: modulo by zero");
        return a % b;
    }

    /**
     Returns the subtraction of two unsigned integers, reverting with custom message on overflow (when the result is negative).
     Counterpart to Solidity's `-` operator.
     - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        return a - b;
    }

    /**
     Returns the integer division of two unsigned integers, reverting with custom message on ivision by zero. The result is rounded towards zero.
     Counterpart to Solidity's `/` operator.
     This function uses a `revert` opcode (which leaves remaining gas untouched) while Solidity
     uses an invalid opcode to revert (consuming all remaining gas).
     - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a / b;
    }

    /**
     Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     reverting with custom message when dividing by zero.
     Counterpart to Solidity's `%` operator. This function uses a `revert` opcode (which leaves remaining gas untouched) while Solidity uses an
     invalid opcode to revert (consuming all remaining gas).
     - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a % b;
    }
}
