// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

///Fund
//WithDraw

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint160 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentlyDeloyed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeloyed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDeloyed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        fundFundMe(mostRecentlyDeloyed);
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeloyed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeloyed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeloyed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        withdrawFundMe(mostRecentlyDeloyed);
    }
}
