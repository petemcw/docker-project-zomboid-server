# Project Zomboid Docker Container

This is a Docker container for Project Zomboid using LinuxGSM.

## How to Use This Image

This image uses two directories for persistent storage:

* `/game-data`, required if you want to keep your game configuration between server restarts.
* `/game-files`, optional, contains the Steam game files for Project Zomboid.

### Sample Run

```bash
docker run -d --name="project-zomboid-server" \
    -v $PWD/files:/game-files \
    -v $PWD/data:/game-data \
    -p 8766:8766/udp \
    -p 8767:8767/udp \
    -p 16261:16261/udp \
    -p 16262-16272:16262-16272 \
    -p 27015:27015 \
    -e ADMIN_PASSWORD="admin-password" \
    -e AUTOSAVE_INTERVAL="10m" \
    -e MOD_WORKSHOP_IDS="2732804047" \
    -e PVP="false" \
    -e RCON_PASSWORD="rcon-password" \
    -e SERVER_NAME="The Best Server" \
    -e SERVER_PASSWORD="server-password" \
    -e SPAWN_POINT="0,0,0" \
    ghcr.io/petemcw/project-zomboid-server
```

## Credit

* <https://github.com/GameServerManagers/LinuxGSM-Docker>
* <https://github.com/cyrale/project-zomboid>
