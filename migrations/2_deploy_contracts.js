var token = artifacts.require("./CodeToken.sol");

module.exports = function(deployer) {
  deployer.deploy(token, 1000000000);
};
