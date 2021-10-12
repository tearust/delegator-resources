#!/usr/bin/env sh

SUB_COMMAND=$1
: ${SUB_COMMAND:="help"}

if [ $SUB_COMMAND = "logs" ]; then
	sudo docker-compose logs -f
elif [ $SUB_COMMAND = "stop" ]; then
	sudo docker-compose down
elif [ $SUB_COMMAND = "clean" ]; then
	rm -rf .layer1/share/tea-camellia/chains/tea-layer1/db
else
	echo "supported subcommands: logs, stop"
fi