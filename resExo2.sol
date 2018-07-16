contract VoteTwoChoices{
    mapping(address => uint) public votingRights;
    mapping(address => uint) public votesCast;
    mapping(bytes32 => uint) public votesReceived;

    /// @dev Get 1 voting right per ETH sent.
    function buyVotingRights() payable {
        votingRights[msg.sender]+=msg.value/(1 ether);
    }

    /** @dev Vote with nbVotes for a proposition.
     *  @param _nbVotes The number of votes to cast.
     *  @param _proposition The proposition to vote for.
     */
    function vote(uint _nbVotes, bytes32 _proposition) {
        require(_nbVotes + votesCast[msg.sender]<=votingRights[msg.sender]); // Check you have enough voting rights.
        require(votesCast[msg.sender] <= votesCast[msg.sender] + _nbVotes);
        require(votesReceived[_proposition] <= votesReceived[_proposition] + _nbVotes);

        votesCast[msg.sender]+=_nbVotes;
        votesReceived[_proposition]+=_nbVotes;
    }

}