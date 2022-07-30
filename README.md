
## Prepare

If you have legacy running program please follow [Clean current running program](#clean-current-running-program) to clean it.

If you don't have a Machine Id for your machine, please follow [generate machine id](https://github.com/tearust/delegator-resources/tree/epoch10#generate-machine-id) to create one. Note machine id will bind with your mining cml, so save it carefully (both hex encoding and base64 encoding formats).

Then you will start mining(aka plant) cml with your hex encoded machine id created above. If you are planting B type cml, you must type the valid and public IPv4 address (for example: 64.227.105.212) related to your machine, and if your are planting C type cml just type a mocked Ip address as you like.

## Run

Run the following command to start or update new version:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch10/install.sh)"
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