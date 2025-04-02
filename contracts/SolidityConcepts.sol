// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityConcepts {
    uint256 public constant FIXED_VALUE = 100;
    address public immutable owner = msg.sender;

    uint256 public value = 50;

    event ValueChanged(uint256 oldValue, uint256 newValue);

    modifier onlyOwner() {
        require(owner == msg.sender, "Not the contract owner");
        _;
    }

    function checkValue(uint256 _value) public pure returns (string memory) {
        return
            _value > 100
                ? "Value is greater than 100"
                : _value == 100
                    ? "Value is exactly 100"
                    : "Value is less than 100";
    }

    function sumUpTo(uint256 _num) public pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 1; i <= _num; i++) {
            sum += i;
        }

        return sum;
    }

    function updateValue(uint256 _newValue) public {
        uint256 oldValue = value;
        value = _newValue;

        emit ValueChanged(oldValue, _newValue);
    }

    function ownerFunction() public view onlyOwner returns (string memory) {
        return "Hello, Owner!";
    }

    receive() external payable {}

    function sendEther(address payable _to) public payable {
        require(msg.value > 0, "Must send ether");
        (bool success, ) = _to.call{value: msg.value}("");
        require(success, "Failed to send ether");
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withDraw() public onlyOwner {
        uint256 amount = address(this).balance;
        payable(msg.sender).transfer(amount);
    }
}
