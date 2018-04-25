# Daemon
```bash
docker run --name SumokoinDaemon --volume daemon:/daemon/data easyhash/sumokoin:latest /daemon/sumokoind --log-level=0 --rpc-bind-ip=0.0.0.0 --rpc-bind-port=18081 --data-dir=/daemon/data
```

# Wallet
```bash
docker run --name SumokoinWallet --volume wallet:/daemon/data --link SumokoinDaemon:daemon easyhash/sumokoin:latest /daemon/sumo-wallet-rpc --daemon-address=http://daemon:18081 --wallet-file=/daemon/data/sumokoin.wallet --rpc-bind-ip=0.0.0.0 --rpc-bind-port=18082 --confirm-external-bind --password '<wallet password>'
```