
## Prepare

If you don't have a Machine Id for your machine, please follow [generate machine id](https://github.com/tearust/delegator-resources/tree/epoch6#generate-machine-id) to create one. Note machine id will bind with your mining cml, so save it carefully (both hex encoding and base64 encoding formats).

Then you will start mining(aka plant) cml with your hex encoded machine id created above.

## Run

Run the following command to install:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch6/install.sh)"
```

During installation, you will see some prompts to input your machine id and layer1 account phase. Please input your machine id with base64 encoding created above and your layer1 account phase, note the layer1 account phase should be the cml owner account you planted.

After setting machine id and layer1 account phase, you should see logs about environment setting, finally you should see the log as follows:
```
docker start completed
```

## Generate machine id

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch6/gen_tea_id.sh)"
```

## Operations after run

Enter into `delegator-resources` directory the is a script file named "tools.sh", you can use the script file like `tools.sh logs` to show current running logs. There are also some sub-commands as following:

- logs: Show current running docker-compose logs
- stop: Stop docker-compose