#!/bin/bash

sudo apt-get install -y wget
# mock-tea-id-generator compiled from https://github.com/tearust/mock-tea-id-generator
wget https://raw.githubusercontent.com/tearust/delegator-resources/epoch6/mock-tea-id-generator
sudo chmod +x mock-tea-id-generator

# subkey compiled from https://github.com/paritytech/substrate
wget https://raw.githubusercontent.com/tearust/delegator-resources/epoch6/subkey
sudo chmod +x subkey

echo "-------- begin of machine id generation --------"
./mock-tea-id-generator
echo "-------- generation completed --------"

echo ""

echo "-------- begin of layer1 account generation --------"
./subkey generate --scheme sr25519
echo "-------- generation completed --------"