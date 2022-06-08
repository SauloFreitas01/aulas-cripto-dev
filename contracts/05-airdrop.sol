pragma solidity >=0.7.0;

import "./03-token.sol";

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Airdrop  {

    // Using Libs

    // Structs

    // Enum
    enum Status { ACTIVE, PAUSED, CANCELLED } // mesmo que uint8


    // Properties
    address private owner;
    address public tokenAddress;
    address[] private subscribers;
    Status contractState; 

    // Modifiers
    modifier isOwner() {
        require(msg.sender == owner , "Sender is not owner!");
        _;
    }

    // Events
    event NewSubscriber(address beneficiary, uint amount);

    // Constructor
    constructor(address token) {
        owner = msg.sender;
        tokenAddress = token;
        contractState = Status.PAUSED;
    }


    // Public Functions

    function subscribe() public returns(bool) {
        //TODO: Need Implementation
        require(hasSubscribed(msg.sender) == false , "Already Subscribed!");
        subscribers.push(msg.sender);

        return( hasSubscribed(msg.sender));
        
    }

    function execute() public isOwner returns(bool) {

        uint256 balance = CryptoToken(tokenAddress).balanceOf(address(this));
        uint256 amountToTransfer = balance / subscribers.length;
        for (uint i = 0; i < subscribers.length; i++) {
            require(subscribers[i] != address(0));
            require(CryptoToken(tokenAddress).transfer(subscribers[i], amountToTransfer));
        }

        return true;
    }

    function state() public view returns(Status) {
        return contractState;
    }


    // Private Functions
    function hasSubscribed(address subscriber) private returns(bool) {
        //TODO: Need Implementation
        uint i =0;
        bool found = false;
         while( i < subscribers.length) {
             subscribers[i] == subscriber? found = true: found =false;
             if(found == true ){
                 break;
             }
             i++;
         }     

         return found;
    }

    // Kill
    function kill() public isOwner {
        //TODO: Need Implementation
        
    // Transfer Eth to owner and terminate contract
    selfdestruct(owner);
    }
    
    
}
