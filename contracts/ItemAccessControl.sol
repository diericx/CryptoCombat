pragma solidity ^0.4.18;

import './ERC721.sol';

// This contract manages the various addresses and constraints for operations
//   that can be executed only by specific roles.
contract ItemAccessControl {
    // TODO - actual functionality for setting these
    // These will not be set yet
    address public ceoAddress;
    address public cfoAddress;
    address public cooAddress;

    modifier onlyCEO() {
        // TODO - uncomment this 
        // require(msg.sender == ceoAddress);
        _;
    }
}