#!/bin/bash
set -e

# Try to get the client version from Anvil
response=$(curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":1}' \
  http://localhost:${PORT:-8545})

# Check if the response has a result
echo $response | grep -q "result" || exit 1

# Exit successfully if we got a response
exit 0