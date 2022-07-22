// SPDX-License-Identifier: GPL-3.0-only

pragma solidity >=0.7.0 <0.9.0;

contract FundNewProject {
    enum IsOpen { Active, Inactive }

    struct Contribution {
        address contributor;
        uint value;
    }

    struct Project {
        string id;
        string name;
        string description;
        address owner;
        address payable ownerWallet;
        uint goal;
        uint total;
        IsOpen isOpen;
    }

    Project[] public projects;
    mapping(string => Contribution[]) public contributions;

    event ProjectCreated(
        string projectId,
        string name,
        string description,
        uint fundraisingGoal
    );

    event FundProject(
        address donor,
        string id,
        uint missing
    );

    event ChangeProjectState(
        string id,
        IsOpen actualState
    );

    modifier onlyOwner(uint projectIndex) {
        require(msg.sender == projects[projectIndex].owner, "You are not the owner of this project");
        _;
    }

    modifier notOwner(uint projectIndex) {
        require(msg.sender != projects[projectIndex].owner, "The Owner can't found its own project");
        _;
    }

    function createNewProject(uint goal, string memory name, string memory description, string memory id) public {
        require(goal > 0, "Goal must be greater than 0");
        Project memory project = Project(id, name, description, msg.sender, payable(msg.sender), goal, 0, IsOpen.Active);
        projects.push(project);
        emit ProjectCreated(id, name, description, goal);
    }

    function reachToGoal(uint projectIndex) public view returns(uint){
        return projects[projectIndex].goal - projects[projectIndex].total;
    }

    function changeProjectState(IsOpen change, uint projectIndex) public onlyOwner(projectIndex){
        Project memory project = projects[projectIndex];
        require(project.isOpen != change, "The new state has to be different");
        project.isOpen = change;
        projects[projectIndex] = project;
        emit ChangeProjectState(project.id, change);
    }
    
    function fundProject(uint projectIndex) public payable notOwner(projectIndex){
        Project memory project = projects[projectIndex];
        //Check if the project is still available
        require(project.isOpen != IsOpen.Inactive, "The project is not longer available");

        //Check amount is different from 0
        require(msg.value > 0, "Please add more than 0 to contribute to the project");

        //If the goal is not reach yet
        require(project.total < project.goal, "The Goal is already reach");

        //Check not exceed the goal
        require(project.total + msg.value <= project.goal, "Unable to add more funds, check amount remaining for our goal");

        project.ownerWallet.transfer(msg.value);
        project.total += msg.value;
        projects[projectIndex] = project;

        contributions[project.id].push(Contribution(msg.sender, msg.value));

        emit FundProject(msg.sender, project.id, reachToGoal(projectIndex));
    }
}