pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract crowdFunding {

    struct Properties {
        uint goal;
        string title;
        address payable creator;
        uint totalFunding;
        uint contributionsCount;
        uint contributorsCount;
    }

    mapping (address => uint) public contributors;
    mapping (uint => Properties) public Projects;
    string[] projectNames;
    uint public index=0;

    function Project(uint _fundingGoal,string memory _title) public {

        require(_fundingGoal > 0, "Project funding goal must be greater than 0");
        
        Projects[index].goal =_fundingGoal;
        Projects[index].title = _title;
        Projects[index].creator = msg.sender;
        Projects[index].totalFunding = 0;
        Projects[index].contributionsCount = 0;
        Projects[index].contributorsCount = 0;
        
        projectNames.push(_title);
        index++;
    }

   
    function getProject(uint _index) public view returns (string memory, uint, address, uint, uint, uint) {
        return (Projects[_index].title,
                Projects[_index].goal,
                Projects[_index].creator,
                Projects[_index].totalFunding,
                Projects[_index].contributionsCount,
                Projects[_index].contributorsCount);
                //yha address(this) return kren ki requirment nhilg rhi
    }

    function fund(uint _index) public payable returns (string memory _result) 
    {

        require(msg.value > 0 ,"Funding contributions must be greater than 0 wei" );

        if (Projects[_index].totalFunding >= Projects[_index].goal) 
        {
           revert("Sorry, the goal has already been reached, Thanks for your efforts.");
        }
        else
        {
            require(Projects[_index].creator.send(msg.value), "Payment Failed");
            
            uint prevContributionBalance = contributors[msg.sender];

            contributors[msg.sender] += msg.value;
    
            Projects[_index].totalFunding += msg.value;
            Projects[_index]. contributionsCount++;
            
            if (prevContributionBalance == 0) {
                Projects[_index].contributorsCount++;
            }

        return("Thanks for your contribution, your contriution is successfully recived.");
        }

    }
    function viewProjects() public view returns(string[] memory)
    {
        return(projectNames);
    }

}