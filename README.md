
## Run

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch6/install.sh)"
```

## Generate machine id

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tearust/delegator-resources/epoch6/gen_tea_id.sh)"
```

## Operations after run

Enter into `delegator-resources` directory the is a script file named "tools.sh", you can use the script file like `tools.sh logs` to show current running logs. There are also some sub-commands as following:

- logs: Show current running docker-compose logs
- stop: Stop docker-compose