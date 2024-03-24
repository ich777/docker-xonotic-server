# Xonotic Dedicated Server in Docker optimized for Unraid

This Docker will download and install the preferred version of Xonotic.
Update Notice: If you want to update the game simply change the version number.


## Env params

| Name | Value | Example |
| --- | --- | --- |
| SERVER_DIR | Folder for gamefiles | /serverdata/serverfiles |
| GAME_PARAMS | Commandline startup parameters (For example if you want use a custom server.cfg file for your server you can append: +serverconfig server.cfg) | empty |
| GAME_VERSION | Preferred game version | 0.8.2 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| BASIC_URL | Basic Download URL | https://dl.xonotic.org/ |

# Run example
```
docker run --name Xonotic -d \
   -p 3979:3979/tcp \
   -p 3979:3979/udp \
   --env 'GAME_PARAMS=' \
   --env 'GAME_VERSION=0.8.2' \
   --env 'UID=99' \
   --env 'GID=100' \
   --env 'BASIC_URL=https://dl.xonotic.org/' \
   --volume /mnt/user/appdata/xonotic:/serverdata/serverfiles \
   --restart=unless-stopped \
   ich777/xonotic:latest
```

This Docker was mainly created for the use with Unraid, if you don’t use Unraid you should definitely try it!

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/