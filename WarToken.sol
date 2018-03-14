pragma solidity ^0.4.16;

import "/browser/ERC20.sol";
import "/browser/SafeMath.sol";

contract WarToken is ERC20 {
    
    using SafeMath for uint;
    
    function tokenFallback (address _from, uint _value, bytes _data);
    
            string public name;
            string public symbol;
            uint public decimals = 18;
            uint256 public totalSupply;
            uint256 public initialSupply = 500000;
    
    mapping (address => uint) public _balanceOf;
    mapping (address => mapping (address => uint256)) public _allowance;
   
    event Transfer (
        address indexed _from, 
        address indexed _to, 
        uint _value, 
        bytes data);
    event Burn (address indexed from, uint256 value);
    
    function WarToken() public {
        totalSupply = initialSupply * 10 ** uint256(decimals); 
        balanceOf[msg.sender] = totalSupply;                
        name = "WarToken";                                   
        symbol = "WTKN";                               
    }
        
        
    function transfer 
    (address _to, uint _value, bytes data) 
    public 
    returns 
    (bool) {
            uint codeLength;
            bytes memory empty;
        assert(_to != 0x0);
        assert(balanceOf[_from] >= _value);
        assert(balanceOf[_to] + _value > balanceOf[_to]);
            uint previousBalances = balanceOf[_from] + balanceOf[_to];
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        assembly {
        codeLength := extcodesize(_to)
            
            }
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
    if(codeLength>0) {
        ERC223ReceivingContract receiver = ERC223ReceivingContract(_to);
        receiver.tokenFallback(msg.sender, _value, _data);
        }
        
        Transfer(msg.sender, _to, _value, _data);
        
    }
          
        
    function transferFrom (
        address _from, 
        address _to, 
        uint256 _value) public returns (bool) {
        assert(_value <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
    return true;
    }
        
        
    function approve (
        address _spender, 
        uint256 _value) public returns (bool) {
        allowance[msg.sender][_spender] = _value;
    return true;
    }
        
        
    function approveAndCall (
        address _spender, 
        uint256 _value, 
        bytes _extraData) public view returns (bool) {
        tokenRecipient spender = tokenRecipient(_spender);
    if (approve(_spender, _value)) {
        spender.receiveApproval(msg.sender, _value, this, _extraData);
    return true;
        }
    }
        
        
    function allowance (address _owner, address _spender) 
    public 
    view 
    returns (uint256 remaining) {
    return allowed[_owner][_spender];
    }
        
        
    function burn (uint256 _value) public returns (bool) {
        assert(balanceOf[msg.sender] >= _value);  
        balanceOf[msg.sender] -= _value;          
        totalSupply -= _value;                     
        emit Burn(msg.sender, _value);
    return true;
    }
        
        
    function burnFrom (address _from, uint256 _value) 
    public 
    returns (bool success) {
        assert(balanceOf[_from] >= _value);             
        assert(_value <= allowance[_from][msg.sender]); 
        balanceOf[_from] -= _value;                    
        allowance[_from][msg.sender] -= _value;        
        totalSupply -= _value;                         
        emit Burn(_from, _value);
    return true;
    }
        
        
    function balanceOf (address _owner) constant returns (uint balance) {
    return balances[_owner];
    }
}