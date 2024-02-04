#!/bin/bash
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

echo "Starting server PRESS CTRL-C to exit"

# Tip: Make a local copy of this script to avoid it being overwritten by steam.
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.
# NOTE: You need to make sure the ports 2456-2458 is being forwarded to your server through your local router & firewall.
# ./valheim_server.x86_64 -name "My server" -port 2456 -world "Dedicated" -password "secret" -crossplay
./valheim_server.x86_64 -name "my easy world" -world "Midgard" \
    -port 2456 \
    -password "youshouldprobablychangeme" \
    -crossplay \
    -public 0 \
    -preset casual \
    -modifier combat veryeasy \
    -modifier deathpenalty casual \
    -modifier resources most \
    -modifier raids none \
    -modifier portals casual \
    -setkey passivemobs

export LD_LIBRARY_PATH=$templdpath