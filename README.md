# minecraft-status-check-http-api
This API can check your Minecraft server status using Minecraft protocol without any server plugins
and provide server status HTTP API in JSON.

This API is used in [tskserver](https://mc.ksswre.net) and [its notification bot](https://github.com/k5342/tskserver-notification-bot)

## example

### `GET /`

```json
{
   "tskserver":{
      "body":{
         "description":{
            "text":"tskserver - mc.ksswre.net"
         },
         "players":{
            "max":20,
            "online":1,
            "sample":[
               {
                  "id":"10361bd2-3e73-45a8-a01c-fbc3cd535656",
                  "name":"k5342"
               }
            ]
         },
         "version":{
            "name":"Spigot 1.12.2",
            "protocol":340
         }
      },
      "last_checked_at":"2017-12-11 09:40:25 +0900",
      "status":"online"
   }
}
```

## dependencies
* [minecraft-socket](github.com/k5342/minecraft-socket)

## Setup

1. clone this repository

2. get dependencies from git submodule
```
git submodule init
git submodule update
```

3. run bundler
```
bundle install --path vendor/bundle
```

4. start the server
```
bundle exec unicorn -c unicorn.rb -E production
```

you can also bind UNIX domain socket with passing the argument `-l <path>`

## TODO
* Get Minecraft server online user using RCON protocol
* Add ping ratency
