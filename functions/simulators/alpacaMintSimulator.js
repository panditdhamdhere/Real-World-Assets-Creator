// TODO
require('dotenv').config();
const requestConfig = require("../configs/alpacaMintConfig")
const { simulateScript, decodeResult } = require("@chainlink/functions-toolkit")

async function main() {
    const { responseBytesHexstring, errorString, } = await simulateScript(requestConfig);

    if (responseBytesHexstring) {
        console.log(`Response returned by scipt: ${decodeResult(responseBytesHexstring, requestConfig.expectedReturnType).toString()}\n`)
    }

    if (errorString) {
        console.log(`Error returned by script: ${errorString}\n`)
    }
}

main().catch((error) => {
    console.error(error)
    process.exitCode = 1
})