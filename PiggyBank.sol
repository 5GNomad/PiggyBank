// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract PiggyBank {
    event Deposit(uint amount);
    event Withdraw(uint amount);
    address public owner = msg.sender;

    modifier isOwner() {
        require(owner == msg.sender, "Not the owner");
        _;
    }

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external payable isOwner {
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }

    function getBalance() external view isOwner returns(uint) {
        return address(this).balance;
    }
}
