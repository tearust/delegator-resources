#!/bin/sh

echo "before create swap:"
free -h

set -x
set -e

sudo fallocate -l 1G /swapfile
ls -lh /swapfile

sudo chmod 600 /swapfile
ls -lh /swapfile

sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show

sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

set +x
set +e

echo "after create swap check:"
free -h