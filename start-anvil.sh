#!/bin/bash
set -e

# Default values
PORT="${PORT:-8545}"
HOST="${HOST:-0.0.0.0}"
CHAIN_ID="${CHAIN_ID:-31337}"
BLOCK_TIME="${BLOCK_TIME:-0}"
FORK_URL="${FORK_URL:-}"
FORK_BLOCK_NUMBER="${FORK_BLOCK_NUMBER:-}"
ACCOUNTS="${ACCOUNTS:-10}"
MNEMONIC="${MNEMONIC:-}"
STEPS_TRACING="${STEPS_TRACING:-false}"
AUTO_MINE="${AUTO_MINE:-true}"

CMD="anvil --host $HOST --port $PORT --chain-id $CHAIN_ID --accounts $ACCOUNTS"

[ "$BLOCK_TIME" != "0" ] && CMD="$CMD --block-time $BLOCK_TIME"
[ -n "$FORK_URL" ] && CMD="$CMD --fork-url $FORK_URL" 
[ -n "$FORK_BLOCK_NUMBER" ] && CMD="$CMD --fork-block-number $FORK_BLOCK_NUMBER"
[ -n "$MNEMONIC" ] && CMD="$CMD --mnemonic \"$MNEMONIC\""
[ "$STEPS_TRACING" = "true" ] && CMD="$CMD --steps-tracing"
[ "$AUTO_MINE" = "false" ] && CMD="$CMD --no-mining"

# Add any additional arguments passed to the script
if [ $# -gt 0 ]; then
    CMD="$CMD $@"
fi

# Print the command being run
echo "Starting Anvil with: $CMD"

# Execute the command
eval $CMD