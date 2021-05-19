const MyToken = artifacts.require("myToken.sol");
module.exports = function (deployer) {
  //next parameters for argument
  deployer.deploy(MyToken,1000000);
  
};
