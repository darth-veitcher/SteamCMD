# Installing SteamCMD

As per [developer.valvesoftware.com](https://developer.valvesoftware.com/wiki/SteamCMD#Ubuntu)

```zsh
sudo add-apt-repository multiverse; sudo dpkg --add-architecture i386; sudo apt update
sudo apt install steamcmd lib32gcc-s1
```

Now setup dedicated user and group for steam

```zsh
sudo adduser --disabled-login steam
```

Create the root directory

```zsh
sudo mkdir -p /data/steam
sudo chown -R steam:steam /data/steam
```
