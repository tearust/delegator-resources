
## Prepare

If you have legacy running program please follow [Clean current running program](#clean-current-running-program) to clean it.

If you don't have a Machine Id for your machine, please follow [generate machine id](https://github.com/tearust/delegator-resources/tree/epoch9#generate-machine-id) to create one. Note machine id will bind with your mining cml, so save it carefully (both hex encoding and base64 encoding formats).

Then you will start mining(aka plant) cml with your hex encoded machine id created above. If you are planting B type cml, you must type the valid and public IPv4 address (for example: 64.227.105.212) related to your machine, and if your are planting C type cml just type a mocked Ip address as you like.

## Run

### Run layer1
Run the following command to install:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch9/install.sh)" "true" "init"
```
If you are running as a validator in layer1, please run the following command instead:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch9/install.sh)" "true" "init" "true"
```

### Run layer2

Run the following command to install:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch9/install.sh)" "false" "init"
```

Finally you should see the log as follows:
```
docker start completed
```

## Generate machine id and account phrase

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch9/gen_tea_id.sh)"
```

## Update new version

Run the following command to update from an existing running version:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch9/install.sh)" "" "update"
```

If you are running as a validator in layer1, please run the following command instead:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch9/install.sh)" "" "update" "true"
```
## Operations after run

Enter into `delegator-resources` directory the is a script file named "tools.sh", you can use the script file like `tools.sh logs` to show current running logs. There are also some sub-commands as following:

- logs: Show current running docker-compose logs
- stop: Stop docker-compose
- clean: Clean legacy data
- health: Check if current running docker-compose is healthy or not
- restart: Restart current running docker-compose file
- sessionkey: Generate your session key

## Clean current running program

Enter into `delegator-resources` directory, run `./tools.sh stop` and `./tools.sh clean` to clean curent running program.