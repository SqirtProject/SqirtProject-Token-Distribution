pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';
import 'zeppelin-solidity/contracts/crowdsale/FinalizableCrowdsale.sol';

import './Token.sol';
import './MainCrowdsale.sol';

contract PreCrowdsale is CappedCrowdsale, FinalizableCrowdsale {

    function PreCrowdsale(uint _startTime,
        uint _endTime,
        uint _rate,
        address _wallet,
        uint _cap,
        uint _minPurchase) public
        Crowdsale(_startTime, _endTime, _rate, _wallet)
        CappedCrowdsale(_cap)

    {
        minPurchase = _minPurchase;
    }

    function createTokenContract() internal returns (MintableToken) {
        token = new Token();
        return token;
    }

    function buyTokens(address beneficiary) public payable {
        if (hasEnded()) {
            finalize();
        }
        require(beneficiary != 0x0);
        require(validPurchase());
        uint weiAmount = msg.value;
        uint tokens = weiAmount.mul(rate);
        require(tokens >= minPurchase);
        weiRaised = weiRaised.add(weiAmount);
        token.transfer(beneficiary, tokens);
        TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);
        forwardFunds();
    }

    function finalization() internal {
        super.finalization();
    }

    Token public token;
    uint public minPurchase;
}
