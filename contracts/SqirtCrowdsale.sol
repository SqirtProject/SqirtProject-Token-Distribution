pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';
import 'zeppelin-solidity/contracts/crowdsale/FinalizableCrowdsale.sol';

import './Token.sol';

contract SqirtCrowdsale is CappedCrowdsale, FinalizableCrowdsale {

    enum State { PRE_SALE, MAIN_SALE }

    function SqirtCrowdsale(uint _preStartTime,
        uint _preEndTime,
        uint _rate,
        address _wallet,
        uint _preCap,
        uint _preMinPurchase,
        uint _mainStartTime,
        uint _mainEndTime,
        uint _mainCap,
        uint _mainMinPurchase) public
        Crowdsale(_preStartTime, _preEndTime, _rate, _wallet)
        CappedCrowdsale(_preCap) {
        minPurchase = _preMinPurchase;
        mainStartTime = _mainStartTime;
        mainEndTime = _mainEndTime;
        mainCap = _mainCap;
        mainMinPurchase = _mainMinPurchase;
        state = State.PRE_SALE;
    }

    function createTokenContract() internal returns (MintableToken) {
        return new Token();
    }

    function buyTokens(address beneficiary) public payable {
        if (hasEnded()) {
            msg.sender.transfer(msg.value);
            finalize();
        }
        require(beneficiary != 0x0);
        require(validPurchase());
        uint weiAmount = msg.value;
        uint tokens = weiAmount.mul(rate);
        require(tokens >= minPurchase);
        weiRaised = weiRaised.add(weiAmount);
        Crowdsale.token.transfer(beneficiary, tokens);
        TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);
        forwardFunds();
    }

    function finalization() internal {
        if (state == State.PRE_SALE) {
            state = State.MAIN_SALE;
            startTime = mainStartTime;
            endTime = mainEndTime;
            cap = mainCap;
            minPurchase = mainMinPurchase;
        }
        super.finalization();
    }

    State public state;
    uint public minPurchase;
    uint public mainStartTime;
    uint public mainEndTime;
    uint public mainCap;
    uint public mainMinPurchase;
}
