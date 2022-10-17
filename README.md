## Run

Run the following command to start or update new version:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/nitro/install.sh)"
```

## Operations after run

Enter into `delegator-resources` directory the is a script file named "tools.sh", you can use the script file like `tools.sh logs` to show current running logs. There are also some sub-commands as following:

- logs: Show current running docker-compose logs
- stop: Stop docker-compose
- clean: Reset running settings
- health: Check if current running docker-compose is healthy or not
- restart: Restart current running docker-compose file

## Clean current running program

Enter into `delegator-resources` directory, run `./tools.sh stop` to stop curent running program.