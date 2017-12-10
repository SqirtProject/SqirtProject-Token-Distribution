pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';
import 'zeppelin-solidity/contracts/crowdsale/FinalizableCrowdsale.sol';

import './Token.sol';
import './PreCrowdsale.sol';

contract MainCrowdsale is CappedCrowdsale, FinalizableCrowdsale {

    function MainCrowdsale(uint _preStartTime,
        uint _preEndTime,
        uint _preRate,
        address _wallet,
        uint _preCap,
        uint _preMinPurchase,
        uint _startTime,
        uint _endTime,
        uint _rate,
        uint _cap,
        uint _minPurchase) public {
        preCrowdsaleContract = new PreCrowdsale(_preStartTime,
                                                _preEndTime,
                                                _preRate,
                                                _wallet,
                                                _preCap,
                                                _preMinPurchase);
    }

    Token public token;
    PreCrowdsale public preCrowdsaleContract;
}
