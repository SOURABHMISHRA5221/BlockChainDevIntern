const HumanFactory = artifacts.require("HumanFactory");

module.exports = function (deployer) {
  deployer.deploy(HumanFactory);
};