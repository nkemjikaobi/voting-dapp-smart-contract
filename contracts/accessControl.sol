// SPDX-License-Identifier: MIT

    pragma solidity ^0.8.6;

/**
    * @title Voting Dapp
    *dev Implements accesscontrol 
 */

contract accesscontrol {

    event GrantRole(bytes32 indexed role, address indexed account);  // emit an event on role granted
    event RevokeRole(bytes32 indexed role, address indexed account); // emit an event on role revoked

    mapping(bytes32 => mapping(address => bool)) public roles;  // role => account => bool

    // 0x6f1713c3dcfc33e04316c5583c762db1239165ee5353f7bf6f1531ea32cde170
    bytes32 private constant Chairperson = keccak256(abi.encode("Chairperson"));  // create a new role identifierr for the chairperson
    // bytes32: 0x9e101246c14498f58cf420aa767bb078df86155192b6d35a6a52e4710b2799af
    bytes32 private constant Teacher = keccak256(abi.encode("Teacher"));
    // bytes32: 0xa354507fc7fd7f7349606b2ebfd009df471253439e5fa705cd7b1d3a6a36b18c
    bytes32 private constant Student = keccak256(abi.encode("Student"));

    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender], "you're not authorized");
        _;
    }
    
    constructor(){
        _grantRole(Chairperson, msg.sender);
    }

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function granteRole(bytes32 _role, address _account) external onlyRole(Chairperson) {
        _grantRole(_role, _account);
    }

    function revokegRole(bytes32 _role, address _account) external onlyRole(Chairperson) {
         roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    } 

}