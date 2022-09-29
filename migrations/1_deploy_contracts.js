const FragPass = artifacts.require("FragPass")

const root = "0x1111111111111111111111111111111111111111111111111111111111111111"

module.exports = function (deployer) {
    deployer.deploy(FragPass, root);
}