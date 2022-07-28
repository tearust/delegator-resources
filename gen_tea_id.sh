#!/bin/bash

TEA_CONFIG="$HOME/.tea"

MEM_SIZE=`grep MemTotal /proc/meminfo | awk '{printf "%.0f", ($2 / 1024)}'`
if [ "$MEM_SIZE" -lt 900 ]; then
  echo "Machine memory size should larger equal than 1G"
  exit 1
fi

sudo apt-get install -y wget

rm -f mock-tea-id-generator
# mock-tea-id-generator compiled from https://github.com/tearust/mock-tea-id-generator
wget https://raw.githubusercontent.com/tearust/delegator-resources/epoch6/mock-tea-id-generator
sudo chmod +x mock-tea-id-generator

hint() {
	echo "//////////////////// copy it //////////////////////"
	echo "/ $HINT_VAR"
	echo "///////////////////////////////////////////////////"
}

rm -f $TEA_CONFIG
touch $TEA_CONFIG

echo "-------- begin machine id generation --------"
TEMP_TEA_ID_PATH=/tmp/gen_tea.temp

./mock-tea-id-generator > $TEMP_TEA_ID_PATH
TEA_ID_HEX=`sed '2q;d' $TEMP_TEA_ID_PATH`
TEA_ID_BASE64=`sed '5q;d' $TEMP_TEA_ID_PATH`

HINT_VAR=$TEA_ID_HEX
hint

echo "TEA_ID=$TEA_ID_BASE64" > $TEA_CONFIG

rm $TEMP_TEA_ID_PATH
echo "-------- generation completed --------"
