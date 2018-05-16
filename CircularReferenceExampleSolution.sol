pragma solidity ^0.4.17;

contract VotethPost {
    string public title;
    string public content;
    address public author;
    string public nickname;
    address[] public votethComments;
    address public votethCommentMaker;
    
    constructor(string _title, string _content, string _nickname) public {
        title = _title;
        content = _content;
        nickname = _nickname;
        author = msg.sender;
        votethCommentMaker = new VotethCommentMaker(); 
    }
    
    function addComment(string _comment, string _nickname) public {
        address comment = new VotethComment(_comment, _nickname, msg.sender, votethCommentMaker);
        votethComments.push(comment);
    }
}

contract VotethComment {
    
    string public comment;
    string public nickname;
    address public author;
    address[] public votethComments;
    address votethCommentMaker;

    constructor(string _comment, string _nickname, address _author, address _votethCommentMaker) public {
        comment = _comment;
        nickname = _nickname;
        author = _author;
        votethCommentMaker = _votethCommentMaker;
    }
    
    function addComment(string _comment, string _nickname) public {
        VotethCommentSupplier votethCommentSupplier = VotethCommentSupplier(votethCommentMaker);
        votethComments.push(votethCommentSupplier.makeComment(_comment, _nickname, msg.sender));
    }
}

contract VotethCommentSupplier {
   function makeComment(string _comment, string _nickname, address _author) public returns(address);
}

contract VotethCommentMaker {
    function makeComment(string _comment, string _nickname, address _author) public returns(address) {
        return new VotethComment(_comment, _nickname, _author, this);
    }
}