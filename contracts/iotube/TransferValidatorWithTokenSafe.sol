pragma solidity <6.0 >=0.4.24;

import "./TokenSafe.sol";
import "./TransferValidatorBase.sol";

contract TransferValidatorWithTokenSafe is TransferValidatorBase {
    TokenSafe public safe;
    constructor(address _safe, address _tokenList, address _witnessList) public {
        safe = TokenSafe(_safe);
        whitelistedTokens = Allowlist(_tokenList);
        whitelistedWitnesses = Allowlist(_witnessList);
    }

    function withdrawToken(address _token, address _to, uint256 _amount) internal returns(bool) {
        return safe.withdrawToken(_token, _to, _amount);
    }

    function upgrade(address _newValidator) public onlyOwner {
        safe.transferOwnership(_newValidator);
    }
}