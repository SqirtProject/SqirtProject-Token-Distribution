pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/token/MintableToken.sol';
import 'zeppelin-solidity/contracts/token/BurnableToken.sol';

contract Token is MintableToken, BurnableToken {

    function Token() public Ownable() {
        balances[msg.sender] = total;
        finishMinting();
    }

    uint public constant total = 50000000 * (10 ** decimals);
    string public constant name = "Sqirt Project Token";
    string public constant symbol = "SQR";
    uint public constant decimals = 7;
}
