#!/usr/bin/env bash

GAS_BUDGET=${GAS_BUDGET:=300000000}
echo "Gas budget: $GAS_BUDGET"

sui client publish --gas-budget "$GAS_BUDGET" "counter" 

exit 0