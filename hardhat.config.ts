import "@typechain/hardhat";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-ethers";
import "hardhat-gas-reporter";
import "dotenv/config";
import "hardhat-deploy"; //namedAccounts comes from here
import "@nomicfoundation/hardhat-toolbox";
//import "solidity-coverage";
import { HardhatUserConfig } from "hardhat/config";

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL || "";
const SEPOLIA_RPC_URL =
    "https://eth-sepolia.g.alchemy.com/v2/x8Tk3UigEvQ6pEq8C3PC8SKZawl3TrU6";
//const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY || "";
export const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || "";
const COINMARKETCAP_API_KEY = process.env.COINMARKETCAP_API_KEY || "";
const config: HardhatUserConfig = {
    solidity: {
        compilers: [{ version: "0.8.17" }, { version: "0.6.6" }],
    },
    defaultNetwork: "hardhat",
    networks: {
        goerli: {
            url: GOERLI_RPC_URL,
            accounts: [PRIVATE_KEY],
            chainId: 5,
        },
        sepolia: {
            url: "https://eth-sepolia.g.alchemy.com/v2/x8Tk3UigEvQ6pEq8C3PC8SKZawl3TrU6",
            chainId: 11155111,
            accounts: [PRIVATE_KEY],
        },
        localhost: {
            url: "http://127.0.0.1:8545/",
            chainId: 31337,
            //accounts: hardhat placed, thanks hardhat :)
        },
    },
    etherscan: {
        apiKey: ETHERSCAN_API_KEY,
    },
    gasReporter: {
        enabled: true,
        outputFile: "gas-report.txt",
        noColors: true,
        currency: "USD",
        coinmarketcap: COINMARKETCAP_API_KEY,
        token: "MATIC",
    },
    namedAccounts: {
        deployer: {
            default: 0,
            31337: 1,
        },
        user: {
            default: 1,
        },
    },
};

export default config;
