// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract FederatedLearningContract{
    event ModelRetrieved(uint256 indexed modelId, string modelHash,string indexed modelName,string  modelAbstract, string  catagory, string indexed endpoint);
    event ModelCount(uint count);
    address public owner;
    struct Model {
        uint256 modelId;
        string modelHash;
        string modelName;
        string modelAbstract;   
        string catagory;
        string endpoint;
    }
    struct Update {
        address user;
        uint256 modelId;
        bytes update;

    }
    mapping(uint256 => Model) public models;
    mapping(uint256 => Update) public updates;
    uint256 public modelCount;
    uint256 public updateCount;
    constructor()  {
        owner = msg.sender;
    }
    function registerModel(string memory _modelHash,string memory _modelName,string memory _modelAbstract, string memory _catagory, string memory _endpoint) public {
        modelCount++;
        models[modelCount] = Model(modelCount, _modelHash,_modelName,_modelAbstract,_catagory, _endpoint);
    }
    function updateModel(uint256 _modelId, bytes memory _update) public {
        updateCount++;
        updates[updateCount] = Update(msg.sender, _modelId, _update);
    }
    function getModel(uint256 _modelId) public  returns (uint256, string memory,string memory,string memory,string memory, string memory) {
        uint256 id = models[_modelId].modelId;
        string memory hash = models[_modelId].modelHash;
        string memory name = models[_modelId].modelName;
        string memory _abstract = models[_modelId].modelAbstract;
        string memory catagory = models[_modelId].catagory;
        string memory endpoint = models[_modelId].endpoint;
        emit ModelRetrieved(id,hash,name,_abstract,catagory,endpoint);
        return (id,hash,name,_abstract,catagory,endpoint);
    }
   
    function getModelCount() public view returns (uint256) {
        return modelCount;
    }
    function getOwner() public view returns (address) {
        return owner;
    }
}
    