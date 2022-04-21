//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Voting {

    // BoardMember => 0
    // Teacher => 1
    // BoardMember => 2
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

    uint public highestVote;

    constructor() {
        chairman = msg.sender;
        _canVote = true;
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
    event VotesVisibilityToggled(bool status);
    event VotingAbilityToggled(bool status);
    event VoteOccurred(string contestantName_, uint userId_);
    event userTypeUpdated(uint userId_, string userType_);
    event userTypeUpdateFailure(string message);

    mapping(address => bool) boardMember;
    mapping(address => bool) teacher;
    mapping(address => bool) student;


    function vote(uint contestantId_, uint userId_) public votingEnabled {

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

    // Compile results
    // function compileResults(userTypes _userType) public isTeacherOrChairman(_userType) {
    //     for (uint i = 0; i < _allContestants.length; i++) {
    //         contestantInfo memory contestant = _allContestants[i];
    //         if(i == 0){
    //             highestVote = contestant.numberOfVotes;
    //         }
    //         if(contestant.numberOfVotes > highestVote){
    //             highestVote = contestant.numberOfVotes;
    //         }
    //     }
    // }

    // Create contestant
    function createContestant(string memory _name) public {
        uint id_ = _allContestants.length + 1;
        _allContestants.push(contestantInfo({id: id_, name: _name, numberOfVotes: 0, hasWon: false}));
        emit contestantCreated(id_, _name, 0, false);
    }

    // Determine if the current address is the chairman
    function checkIfChairman(address user) public view returns (bool) {
        return chairman == user;
    }

    // Determine if voting is enabled or disabled
    function isVotingEnabled() public view returns (bool) {
        return _canVote;
    }

    /// return all contestants
    function getContestants() public view returns (contestantInfo[] memory) {
        return _allContestants;
    }

    /// return all users
    function getUsers() public view returns (userInfo[] memory) {
        return allUsers;
    }

    // Function to update can vote field
    function updateCanVote(bool visibility) public isChairman {
        _canVote = visibility;
        emit VotingAbilityToggled(visibility);
    }

    function getCanVote() public view returns(bool){
        return _canVote;
    }

    // Toggle the ability to vote... This can only be modified by the Chairman of the board of directors
    // function toggleVoting(bool _visibility) public isChairman {
    //     updateCanVote(_visibility);
    //     emit VotingAbilityToggled(_visibility);
    // }

    // Function to update votes visibility
    function updateVotesVisibility(bool visibility, uint _userType) public isTeacherOrBoardMember(_userType){
        _isVoteVisible = visibility;
        emit VotesVisibilityToggled(visibility);
    }



    // Toggle the visibility of votes
    // function toggleVotesVisibility(bool _visibility, uint _userType) public isTeacherOrBoardMember(_userType) {
    //     updateVotesVisibility(_visibility);
    //     emit VotesVisibilityToggled(_visibility);
    // }
}