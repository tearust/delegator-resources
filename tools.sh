#!/usr/bin/env sh

SUB_COMMAND=$1
: ${SUB_COMMAND:="help"}

if [ $SUB_COMMAND = "logs" ]; then
	docker-compose logs -f
elif [ $SUB_COMMAND = "stop" ]; then
	docker-compose down
else
	echo "supported subcommands: logs, stop"
fi