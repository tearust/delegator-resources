## Run

Run the following command to start or update new version:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch13/install.sh)"
```

Or using the following command without prompting:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch13/install.sh)" "" "0x0000000000000000000000000000000000000000000000000000000000000000" "0xbd6D4f56b59e45ed25c52Eab7EFf2c626e083db9"
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