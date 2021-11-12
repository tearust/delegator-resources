#!/usr/bin/env sh

SUB_COMMAND=$1
: ${SUB_COMMAND:="help"}

if [ $SUB_COMMAND = "logs" ]; then
	sudo docker-compose logs -f
elif [ $SUB_COMMAND = "stop" ]; then
	sudo docker-compose down
elif [ $SUB_COMMAND = "clean" ]; then
	rm -rf .layer1/share/tea-camellia/chains/tea-layer1/db
elif [ $SUB_COMMAND = "health" ]; then
	sudo docker-compose ps
elif [ $SUB_COMMAND = "restart" ]; then
	sudo docker-compose down
	sudo docker-compose up -d
else
	echo "supported subcommands: logs, stop, restart, clean, health"
fi