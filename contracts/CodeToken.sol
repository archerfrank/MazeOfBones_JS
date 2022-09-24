pragma solidity >=0.4.21 <0.9.0;

import './2_Owner.sol';
import './SafeMath.sol';

/**
 * 发布的token
 */
contract CodeToken is Owner {

    using SafeMath for uint;

    address public owner;
    mapping (address => uint) private _balances;
    uint private _totalSupply;

    constructor (uint initialSupply) public {
        _totalSupply = initialSupply;
        _balances[msg.sender] = initialSupply;
    }

    function totalSupply() public view returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint) {
        return _balances[account];
    }

    function move(address recipient, uint amount, string memory from, string memory to) external returns (bool) {
        bool airdrop = (_balances[recipient] == 0);
        require(msg.sender == owner || !airdrop, "Only allowed address can be transferred to.");
        _balances[msg.sender] = _balances[msg.sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        if (airdrop) {
            emit AirdropEvent(msg.sender, recipient, amount, from , to);
        } else {
            emit TransferEvent(msg.sender, recipient, amount, from , to);
        }
        return true;
    }


    function transfer(address recipient, uint amount) external returns (bool){
        require(1 == 0, "ERC20: You must transfer token using move method");
        return false;
    }


    function allowance(address owner, address spender) external view returns (uint){
        require(1 == 0, "not implemented");
        return 0;
    }

    function approve(address spender, uint amount) external returns (bool){
        require(1 == 0, "not implemented");
        return false;
    }


    function transferFrom(address sender, address recipient, uint amount) external returns (bool){
        require(1 == 0, "not implemented");
        return false;
    }

    event TransferEvent(address indexed fromAddr, address indexed toAddr, uint value, string from, string to);
    event AirdropEvent(address indexed fromAddr, address indexed toAddr, uint value, string from, string to);
}