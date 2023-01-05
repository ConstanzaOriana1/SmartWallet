//SPDX-License-Identifier: MIT;

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
IMPORT "@openzeppelin/contracts/interfaces/IERC20.sol";

contract SmartWallet {
    ERC20 public token;

    event transfer (address _from, addres _to, address _token, uint256 _value);

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
    //Ingresar evento aca?
}
}
