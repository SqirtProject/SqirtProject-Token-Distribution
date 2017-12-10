pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';

import './Token.sol';

contract PreCrowdsale is CappedCrowdsale {

    function PreCrowdsale(uint _startTime,
        uint _endTime,
        uint _rate,
        address _wallet,
        uint _cap) public
        Crowdsale(_startTime, _endTime, _rate, _wallet)
        CappedCrowdsale(_cap)
    {

    }

    function createTokenContract() internal returns (MintableToken) {
        return new Token();
    }

    function buyTokens(address beneficiary) public payable {
        require(beneficiary != 0x0);
        require(validPurchase());
        uint weiAmount = msg.value;
        uint tokens = weiAmount.mul(rate);
        weiRaised = weiRaised.add(weiAmount);
        token.transfer(beneficiary, tokens);
        TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);
        forwardFunds();
    }
}
