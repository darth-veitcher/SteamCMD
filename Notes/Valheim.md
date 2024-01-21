# Valheim

## Using SteamCMD

The `id` for the server is `896660` (this is different to the client).

So command would be as follows to install:

```zsh
export APP_ID=896660
export INSTALL_DIR=/opt/valheim_server
steamcmd +force_install_dir $INSTALL_DIR +login anonymous +app_update $APP_ID validate +quit
```
