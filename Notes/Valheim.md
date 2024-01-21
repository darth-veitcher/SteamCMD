# Valheim

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
