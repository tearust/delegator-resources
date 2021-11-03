#!/bin/bash

sudo apt-get install -y wget
wget https://raw.githubusercontent.com/tearust/delegator-resources/epoch6/mock-tea-id-generator
sudo chmod +x mock-tea-id-generator
./mock-tea-id-generator