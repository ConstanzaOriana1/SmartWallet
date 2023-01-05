//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


 /// @notice Create smart wallet in order to the contract/wallet receives a metadata transaction from the user (gasless) and can transform that data into the execution of a function that has token, amount and recipient as parameters
contract SmartWallet is Ownable {
    ERC20 public _token;

    bool whitelist;

    event transfer (address owner, address to, address token, uint256 value);
    event batchTransfered (address owner, address [] to, address [] token, uint256 [] value);

   modifier whenNotPaused () {
        require(true,"contract is paused");
   }

   modifier IsWhitelisted(address){
        require (whitelist(address),"Address not whitlisted");
   }

 /// @notice allows transfer ERC20 tokens between smart wallets
 /// @dev Juan Cruz Suarez - Matias Zapata - Constanza Oriana
 /// @param address owner - Sender account 
 /// @param address to - Receiver account 
 /// @param address token - Token to send contract address
 /// @param uint256 value - Amount of tokens to transfer
 /// @param uint8 v, bytes32 r, bytes32 s - Validates secp256k1 signature
function transferToken(
    address owner,
    address to,
    address token,
    uint256 value,
    uint8 v,
    bytes32 r,
    bytes32 s
) external whenNotPaused IsWhitelisted(owner) IsWhitelisted(to) {
    _transferToken(owner, to, token, value, v, r, s);
}

function _transferToken (
    address owner,
    address to,
    address token,
    uint256 value,
    uint8 v,
    bytes32 r,
    bytes32 s
) internal {
    bytes memory data = abi.encode(
        PERMIT_TYPEHASH, 
        owner,
        to,
        value,
        _permitNonces[owner]++)
;
require(
    EIP712.recover(DOMAIN_SEPARATOR, v, r, s, data) == owner, "Invalid signature");
    _token=ERC20(token);
    _token.transfer(to, value);

    emit transfer (owner, to, token, value);
}
 /// @notice To transfer a batch of transactions
 /// @dev Juan Cruz Suarez - Matias Zapata - Constanza Oriana
 /// @param address owner - Sender account 
 /// @param address [] to - List of receivers accounts 
 /// @param address [] token - List of token to send, contract address 
 /// @param uint256 [] value - List of amount to transfer
 /// @param uint8 v, bytes32 r, bytes32 s - Validates secp256k1 signature


function transferBatch (
    address owner,
   address [] to, 
   address [] token, 
   uint256 [] value,
    uint8 v,
    bytes32 r,
    bytes32 s
) external whenNotPaused IsWhitelisted(owner)
IsWhitelisted(to) {
    _transferToken(owner, to, token, value, v, r, s);
}

/// @notice Internal function
 /// @dev Juan Cruz Suarez - Matias Zapata - Constanza Oriana
 /// @param address owner - Sender account 
 /// @param address [] to - List of receivers accounts 
 /// @param address [] token - List of token to send, contract address 
 /// @param uint256 [] value - List of amount to transfer
 /// @param uint8 v, bytes32 r, bytes32 s - Validates secp256k1 signature
function _transferBatch (
address owner,
   address [] to, 
   address [] token, 
   uint256 [] value,
    uint8 v,
    bytes32 r,
    bytes32 s
) internal {
    bytes memory data = abi.encode(
        PERMIT_TYPEHASH, 
        owner,
        spender,
        value,
        _permitNonces[owner]++)
;
require(
    EIP712.recover(DOMAIN_SEPARATOR, v, r, s, data) == owner, "Invalid signature");

    for (uint i=0;i<to.length;i++){
    _token=ERC20(token[i]);
    _token[i].transfer(to[i],value[i]);
    }
    

    emit batchTransfered (owner, to, token, value);

}

/// @notice If account is not been used, destoy and recover ETH
 /// @dev Juan Cruz Suarez - Matias Zapata - Constanza Oriana
function destroyAndRecover () public onlyOwner view {
selfdestruct(owner);
}

}
