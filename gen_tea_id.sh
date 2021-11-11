#!/bin/bash

TEA_CONFIG="$HOME/.tea"

sudo apt-get install -y wget
# mock-tea-id-generator compiled from https://github.com/tearust/mock-tea-id-generator
wget https://raw.githubusercontent.com/tearust/delegator-resources/epoch6/mock-tea-id-generator
sudo chmod +x mock-tea-id-generator

# subkey compiled from https://github.com/paritytech/substrate
wget https://raw.githubusercontent.com/tearust/delegator-resources/epoch6/subkey
sudo chmod +x subkey

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

echo "MY_TEA_ID=\"$TEA_ID_BASE64\"" > $TEA_CONFIG

rm $TEMP_TEA_ID_PATH
echo "-------- generation completed --------"

echo ""

echo "-------- begin layer1 account generation --------"
TEMP_LAYER1_PATH=/tmp/gen_layer1.temp

./subkey generate --scheme sr25519 > $TEMP_LAYER1_PATH

sed -ri "s@(\s*)(SS58 Address:\s*)@@" $TEMP_LAYER1_PATH
sed -ri "s@(\s*)(Secret phrase:\s*)@@" $TEMP_LAYER1_PATH

LAYER1_PHASE=`sed '1q;d' $TEMP_LAYER1_PATH`
LAYER1_ADDRESS=`sed '6q;d' $TEMP_LAYER1_PATH`

HINT_VAR=$LAYER1_ADDRESS
hint

echo "MY_LAYER1_ACCOUNT=\"$LAYER1_PHASE\"" >> $TEA_CONFIG

rm $TEMP_LAYER1_PATH
echo "-------- generation completed --------"