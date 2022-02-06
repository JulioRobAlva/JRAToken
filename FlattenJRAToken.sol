// SPDX-License-Identifier: MIT
// File: https://github.com/JulioRobAlva/JRAToken/blob/main/SafeMath.sol



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

// File: https://github.com/JulioRobAlva/JRAToken/blob/main/IERC20JRA.sol



pragma solidity >=0.6.0 <=0.8.11;

/**
 Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     Moves `amount` tokens from the caller's account to `recipient`.
     Returns a boolean value indicating whether the operation succeeded.
     Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     Returns the remaining number of tokens that `spender` will be
     allowed to spend on behalf of `owner` through {transferFrom}. This is zero by default.
     This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     Sets `amount` as the allowance of `spender` over the caller's tokens.
     Returns a boolean value indicating whether the operation succeeded.
     Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     Moves `amount` tokens from `sender` to `recipient` using the
     allowance mechanism. `amount` is then deducted from the caller's allowance.
     Returns a boolean value indicating whether the operation succeeded.
     Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     Emitted when `value` tokens are moved from one account (`from`) to another (`to`).
     Check that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     Emitted when the allowance of a `spender` for an `owner` is set by a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: https://github.com/JulioRobAlva/JRAToken/blob/main/Context.sol



pragma solidity >=0.6.0 <=0.8.11;

/*
 Provides information about the current execution context, including the
 sender of the transaction and its data. While these are generally available
 via msg.sender and msg.data, they should not be accessed in such a direct
 manner, since when dealing with GSN meta-transactions the account sending and
 paying for execution may not be the actual sender.
 This contract is only required for intermediate, library-like contracts.
 */

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: https://github.com/JulioRobAlva/JRAToken/blob/main/ERC20JRA.sol



pragma solidity >=0.6.0 <=0.8.11;




/**
 Implementation of the {IERC20} interface.
 */
contract ERC20 is Context, IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     Sets the values for {name} and {symbol}, initializes {decimals} with a default value of 18.
     */
    constructor (string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = 18;
    }

    /**
     Returns the name of the token.
     */
    function name() public view virtual returns (string memory) {
        return _name;
    }

    /**
     Returns the symbol of the token, usually a shorter version of the name.
     */
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    /**
     Returns the number of decimals used to get its user representation.
     */
    function decimals() public view virtual returns (uint8) {
        return _decimals;
    }

    /**
     See IERC20-totalSupply.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     See IERC20-balanceOf.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     See IERC20-transfer.
     - `recipient` cannot be the zero address.
     - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     See IERC20-allowance.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     See IERC20-approve.
     - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     See IERC20-transferFrom.
     Emits an {Approval} event indicating the updated allowance.
     - `sender` and `recipient` cannot be the zero address.
     - `sender` must have a balance of at least `amount`.
     - the caller must have allowance for ``sender``'s tokens of at least `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    /**
     Atomically increases the allowance granted to `spender` by the caller.
     Emits an {Approval} event indicating the updated allowance.
     - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     Atomically decreases the allowance granted to `spender` by the caller.
     Emits an {Approval} event indicating the updated allowance.
     - `spender` cannot be the zero address.
     - `spender` must have allowance for the caller of at least `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    /**
     Moves tokens `amount` from `sender` to `recipient`.
     This is internal function is equivalent to {transfer}, and can be used to implement automatic token fees, slashing mechanisms, etc.
     Emits a {Transfer} event.
     - `sender` cannot be the zero address.
     - `recipient` cannot be the zero address.
     - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** 
     Creates `amount` tokens and assigns them to `account`, increasing the total supply.
     Emits a {Transfer} event with `from` set to the zero address.
     - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     Destroys `amount` tokens from `account`, reducing the total supply.
     Emits a {Transfer} event with `to` set to the zero address.
     - `account` cannot be the zero address.
     - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    /**
     Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     This internal function is equivalent to `approve`, and can be used to set automatic allowances for certain subsystems, etc.
     Emits an {Approval} event.
     - `owner` cannot be the zero address.
     - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     Sets {decimals} to a value other than the default one of 18.
     */
    function _setupDecimals(uint8 decimals_) internal virtual {
        _decimals = decimals_;
    }

    /**
     Hook that is called before any transfer of tokens. This includes minting and burning.
     - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens will be to transferred to `to`.
     - when `from` is zero, `amount` tokens will be minted for `to`.
     - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     - `from` and `to` are never both zero.
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }
}

// File: JRAToken.sol



pragma solidity >=0.6.0 <=0.8.11;


contract JRAToken is ERC20 {
    constructor() ERC20("JulioRobAlva", "JRA") {
        _mint(msg.sender , 21000000 ether);
        
        }
    }o