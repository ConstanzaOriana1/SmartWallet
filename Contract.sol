//SPDX-License-Identifier: MIT;

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";

contract SmartWallet {
    ERC20 public token;

    event transfer (address owner, addres to, address token, uint256 value);


 /// @notice Create smart wallet in order to the contract/wallet receives a metadata transaction from the user (gasless) and can transform that data into the execution of a function that has token, amount and recipient as parameters
 /// @dev Juan Cruz Suarez - Matias Zapata - Constanza Oriana
 /// @param address owner - Sender account 
 /// @param address to - Receiver account 
 /// @param address token - 
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
) external whenNotPausedIsWhitelisted(owner)
isWhiteListed(to) {
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
        spender,
        value,
        _permitNonces[owner]++)
;
require(
    EIP712.recover(DOMAIN_SEPARATOR, v, r, s, data) == owner, "Invalid signature");
    token.transfer(to, value);

    //Ingresar event aca?
    //emit transfer (owner, to, token, value);

}
}
