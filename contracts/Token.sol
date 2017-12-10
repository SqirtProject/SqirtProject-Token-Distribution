pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/token/StandardToken.sol';

contract Token is StandardToken {

    function Token() public {
        balances[msg.sender] = total;
    }

    uint public constant total = 50000000 * (10 ** decimals);
    string public constant name = "Sqirt Project Token";
    string public constant symbol = "SQR";
    uint8 public constant decimals = 7;
}
