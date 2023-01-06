SMART WALLET
Create a contract for each user that works as a wallet. It holds tokens and allows transfer to others whitelisted users.

To pay for the fees the contract will have native tokens to pay for each transfer. -The contract will work with meta-transactions to recive EIP-712 (signed msg) this way user won't have to pay for fees when interacting with relay contract (!! looking to implement a way that smart wallet directly understand EIP-712 and make transaction).

Wallets will be ownable by sphereone so when its necessary user can be blacklisted, contract can be paused or destoyed.

Wallets will only recieve signed msg that came from de relay contract (Looki)

It has a transfer function for individual transfer and a "transferBatch" for multi transactions

** STEPS **

1 - create smart wallet a- IERC20 so it can holds ERC20 Tokens ✅ b- Implement functions to send ERC20 Tokens ✅ c- The contract must own some eth so it can pay gas d- Implement a way to recover eth if account is unused. e- Implement requirements for whitelist users and non paused wallet.

2- create a relay contract (if necesary) a- It should recive EIP-721 and talk to specific users wallet for this to make the transactions.
