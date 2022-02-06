// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <=0.8.11;

import "./Context.sol";
import "./IERC20.sol";
import "./SafeMath.sol";

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
     Sets the values for {name} and {symbol}.
     */
    constructor (string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = 4;
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
