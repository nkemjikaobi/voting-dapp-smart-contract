//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Voting {

    // BoardMember => 0
    // Teacher => 1
    // Student => 2
    enum userTypes
    {
      BoardMember,
      Teacher,
      Student
    } 

    struct voteInfo {
        uint id;
        uint contestantId;
    }

    struct contestantInfo {
        uint id;
        string name;
        uint numberOfVotes;
        bool hasWon;
    }

    struct userInfo {
        uint userId;
        address userAddress;
        string userType;
        bool hasVoted;
    }

    address chairman;

    uint private _totalNumberOfVotes;
    
    voteInfo[] private _allVotesInfo;

    contestantInfo[] private _allContestants;

    userInfo[] private allUsers;

    bool public _canVote;

    bool public _isVoteVisible;

    bool public _isVotingEnded;

    uint public highestVote;

    constructor() {
        chairman = msg.sender;
        _canVote = true;
        _isVotingEnded = false;
        createUser(msg.sender, 0);
    }

    modifier isChairman {
        require(msg.sender == chairman, "Only the chairman is allowed to modify");
        _;
    }

    modifier isTeacherOrBoardMember(uint _userType) {
      require(_userType == 0 || _userType == 1, "You are not authorized");
       _;
    }

    modifier isTeacherOrChairman(uint _userType) {
      require(_userType == 1 || msg.sender == chairman, "You are not authorized");
       _;
    }

    modifier votingEnabled() {
        require (_canVote == true);
        _;
    }

    //event VoteOccured(uint id, string name);
    event userCreated(uint userId, address userAddress, uint userType, bool hasVoted);
    event userCreationFailed(string message);
    event contestantCreated(uint contestantId, string name, uint numberOfVotes, bool hasWon);
    event VotesVisibility(bool status);
    event VotingDisabled(bool status);
    event VotingEnabled(bool status);
    event VoteOccurred(string contestantName_, uint userId_);
    event userTypeUpdated(uint userId_, string userType_);
    event userTypeUpdateFailure(string message);
    event VotingEnded();

    mapping(address => bool) boardMember;
    mapping(address => bool) teacher;
    mapping(address => bool) student;


    function vote(uint contestantId_, uint userId_) public votingEnabled {

        //Check that voting has not ended
        require(_isVotingEnded == false, "Voting has ended");

        //Check that the user has not voted before
        require(allUsers[userId_ - 1].hasVoted == false, "You cannot vote twice");

        //Change hasVoted status of user to true
        allUsers[userId_ - 1].hasVoted = true;

        //Add to the voteInfo array
        uint id_ = _allVotesInfo.length + 1;
        _allVotesInfo.push(voteInfo({id: id_, contestantId: contestantId_}));

        
        //Increase the contestant votes
        _allContestants[contestantId_ - 1].numberOfVotes++;
        emit VoteOccurred(_allContestants[contestantId_ - 1].name, userId_);
    }

    // Create user
    function createUser(address _userAddress, uint _userType) public isChairman {
        require(_userType == 0 || _userType == 1 || _userType == 2, "User type does not exist");
        if(_userType == 0){
            uint id_ = allUsers.length + 1;
            allUsers.push(userInfo({userId: id_, userAddress: _userAddress, userType: "BoardMember", hasVoted: false}));
            emit userCreated(id_, _userAddress, _userType, false);
        }
        else if(_userType == 1){
            uint id_ = allUsers.length + 1;
            allUsers.push(userInfo({userId: id_, userAddress: _userAddress, userType: "Teacher", hasVoted: false}));
            emit userCreated(id_, _userAddress, _userType, false);
        }
        else if(_userType == 2){
            uint id_ = allUsers.length + 1;
            allUsers.push(userInfo({userId: id_, userAddress: _userAddress, userType: "Student", hasVoted: false}));
            emit userCreated(id_, _userAddress, _userType, false);
        }
        
    }

    // Change a user type
    function changeUserType(uint userId_, uint _userType) public isChairman {
        require(userId_ != 1, "You cannot update yourself");
        require(_userType == 0 || _userType == 1 || _userType == 2, "User type does not exist");

        if(_userType == 0){
            allUsers[userId_ - 1].userType = "BoardMember";
            emit userTypeUpdated(userId_, "BoardMember");
        }
        else if(_userType == 1){
            allUsers[userId_ - 1].userType = "Teacher";
            emit userTypeUpdated(userId_, "Teacher");
        }
        else if(_userType == 2){
            allUsers[userId_ - 1].userType = "Student";
            emit userTypeUpdated(userId_, "Student");
        }
       
    }

    // Create contestant
    function createContestant(string memory _name) public {
        uint id_ = _allContestants.length + 1;
        _allContestants.push(contestantInfo({id: id_, name: _name, numberOfVotes: 0, hasWon: false}));
        emit contestantCreated(id_, _name, 0, false);
    }

    //Coolate results
    function collateResults(uint _userType) public isTeacherOrBoardMember(_userType){
        _isVotingEnded = true;
        emit VotingEnded();
    }

    // Check if the user exists
    function isValidUser(address userAddress) public view returns (bool) {
        bool result = false;
        for (uint i = 0; i < allUsers.length; i++) {
            if(allUsers[i].userAddress == userAddress){
                result = true;
            }
        }
        return result;
    }

    // Determine if the current address is the chairman
    function checkIfChairman(address user) public view returns (bool) {
        return chairman == user;
    }

    // Determine if voting is enabled or disabled
    function isVotingEnabled() public view returns (bool) {
        return _canVote;
    }

    // Determine if voting has ended
    function isVotingEnded() public view returns (bool) {
        return _isVotingEnded;
    }

    // Determine if voting is visible or hidden
    function isVotingVisible() public view returns (bool) {
        return _isVoteVisible;
    }

    /// return all contestants
    function getContestants() public view returns (contestantInfo[] memory) {
        return _allContestants;
    }

    /// return all users
    function getUsers() public view returns (userInfo[] memory) {
        return allUsers;
    }

    //return all votes
    function fetchVotes() public view returns (voteInfo[] memory) {
        return _allVotesInfo;
    }

    // Function to disable voting on the platform
    function disbaleVote() public isChairman {
        _canVote = false;
        emit VotingDisabled(false);
    }

    // Function to enable voting on the platform
    function enableVote() public isChairman {
        _canVote = true;
        emit VotingEnabled(true);
    }

    // Function to disable votes visibility
    function hideVotesVisibility(uint _userType) public isTeacherOrBoardMember(_userType){
        _isVoteVisible = false;
        emit VotesVisibility(false);
    }

    // Function to show votes visibility
    function showVotesVisibility(uint _userType) public isTeacherOrBoardMember(_userType){
        _isVoteVisible = true;
        emit VotesVisibility(true);
    }

}