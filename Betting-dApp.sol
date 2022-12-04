pragma solidity ^0.8.4;
import "./Mytoken.sol";


contract Betting{
   MyToken public MTN;
   address public owner = msg.sender;


   constructor(MyToken _MTN) public{
       MTN = _MTN;
       owner == msg.sender;
   }

   modifier onlyowner(){
       require(msg.sender == owner, "You are not the owner");
   _;
   }

   string[] public Betterscomments;
   address[] public Betters;
   mapping(address=>uint256) public   Bettingbalance;
   uint256 public TotalBet;

    mapping(address => bool) public hasBet;
    mapping(address => bool) public isBetting;

   function Bet(uint256 amount) public payable{
       require(amount == 1000, "You don't have enough Token");
       MTN.transferFrom(msg.sender, 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB, 1000 );
       TotalBet = TotalBet+ amount;
       Bettingbalance[msg.sender] =Bettingbalance[msg.sender] + amount;
       if(!hasBet[msg.sender]){
       Betters.push(payable(msg.sender));
       }
          //updating staking status
        hasBet[msg.sender] = true;
        isBetting[msg.sender] = true;    
   }

   function distributeReward() public payable onlyowner{
     for (uint256 i = 0; i < Betters.length; i++) {
            address recipient = Betters[i];
                MTN.transfer(recipient, 2000);
            }
            Betters = new address payable[](0);
     
   }


   function AddComment(string memory comments) public returns(string[] memory) {
       Betterscomments.push(comments);
   }

    function getComments() public view returns(string[] memory){
        return Betterscomments;
    }
}
