# Valheim

Note: in order for crossplay to work - as of Jan 2024 - you need to add the following libraries to ubuntu.

```zsh
sudo apt install -y libpulse-dev libatomic1 libc6
```

## Using SteamCMD

The `id` for the server is `896660` (this is different to the client).

So command would be as follows to install:

```zsh
export APP_ID=896660
export INSTALL_DIR=/opt/valheim_server
steamcmd +force_install_dir $INSTALL_DIR +login anonymous +app_update $APP_ID validate +quit
```

Assuming this is installed a basic run command would look like the below (based on Linux, adjust for Windows):

```zsh
# Linux
$INSTALL_DIR/valheim_server.x86_64 -name "My super Viking meadfest" -world "Midgard" -port 2456 -password "megas3cret!"

# Windows
$INSTALL_DIR/valheim_server.exe -name "My super Viking meadfest" -world "Midgard" -port 2456 -password "megas3cret!"
```

These additional flags are worth considering:

```zsh
-crossplay
-public 0
-nographics
-batchmode
```

As a result a basic bash script might look as follows:

```zsh
#! /usr/env bash
export SteamAppId=896660
export INSTALL_DIR=/data/local/valheim_server
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$INSTALL_DIR/linux64:$LD_LIBRARY_PATH
steamcmd +force_install_dir $INSTALL_DIR +login anonymous +app_update $SteamAppId validate +quit
$INSTALL_DIR/valheim_server.x86_64 -nographics -batchmode \
    -name "My super Viking meadfest" -world "Midgard" \
    -port 2456 \
    -password "megas3cret!" \
    -crossplay \
    -public 0 \
    -preset casual \
    -modifier combat veryeasy \
    -modifier deathpenalty casual \
    -modifier resources most \
    -modifier raids none \
    -modifier portals casual \
    -setkey passivemobs
```

Interestingly the default script looks like this

```zsh
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

echo "Starting server PRESS CTRL-C to exit"

# Tip: Make a local copy of this script to avoid it being overwritten by steam.
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.
# NOTE: You need to make sure the ports 2456-2458 is being forwarded to your server through your local router & firewall.
./valheim_server.x86_64 -name "My server" -port 2456 -world "Dedicated" -password "secret" -crossplay

export LD_LIBRARY_PATH=$templdpath
```

## Firewall

Need to open `2456-2458` and `27060` for `udp`.

```zsh
sudo ufw allow 2456/udp
sudo ufw allow 2457/udp
sudo ufw allow 2458/udp
sudo ufw allow 27060/udp
```

Or as a profile

```conf
# file: /etc/ufw/applications.d/valheim
# Used to configure the ufw definition for a Valheim dedicated server

[valheim]
title=Valheim Server
description=Valheim is a brutal exploration and survival game for 1-10 players set in a procedurally-generated world inspired by Norse mythology. Craft powerful weapons, construct longhouses, and slay mighty foes to prove yourself to Odin!
ports=2456:2458,27060/udp|8472/udp
```

```zsh
sudo ufw app update valheim
sudo ufw allow valheim
```

A systemd service at `/etc/systemd/system/valheim.service`

```conf
[Unit]
Description=Valheim service
Wants=network-online.target
After=syslog.target network.target nss-lookup.target network-online.target

[Service]
Type=simple
Restart=on-failure
RestartSec=10
StartLimitInterval=60s
StartLimitBurst=3
User=adminlocal
Group=adminlocal
ExecStartPre=/usr/games/steamcmd +login anonymous +force_install_dir /data/local/valheim_server +app_update 896660 validate +exit
ExecStart=/data/local/valheim_server/start_server.sh
ExecReload=/bin/kill -s HUP $MAINPID
KillSignal=SIGINT
WorkingDirectory=/data/local/valheim_server
LimitNOFILE=100000

[Install]
WantedBy=multi-user.target
```

```zsh
sudo systemctl daemon-reload
sudo systemctl enable --now valheim.service
```
