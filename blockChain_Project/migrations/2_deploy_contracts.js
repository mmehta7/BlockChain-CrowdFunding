var crowdFunding = artifacts.require("./crowdFunding.sol");

module.exports = function(deployer) {
  deployer.deploy(crowdFunding);
};
