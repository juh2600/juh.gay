---
title: 330-configmap
date: 2024-06-16
authors:
  - juh
prev: 320-pvc
next: 340-deployment
---
> [!file]+ 25-configmap.yaml
> ```yaml
> apiVersion: v1
> kind: ConfigMap
> metadata:
>   name: smp-164-config
>   namespace: mcd
>   labels:
>     app: mcd
>     style: smp # gamemode=0
>     version: 1.6.4
> data:
>   server.properties: |
>     allow-flight=false
>     allow-nether=true
>     difficulty=1
>     enable-query=false
>     enable-rcon=true
>     force-gamemode=false
>     gamemode=0
>     generate-structures=true
>     generator-settings=
>     hardcore=false
>     level-name=world
>     level-seed=
>     level-type=DEFAULT
>     max-build-height=256
>     max-players=20
>     motd=the revolution will not be televised
>     online-mode=true
>     player-idle-timeout=0
>     pvp=true
>     rcon.password=eebydeeby
>     rcon.port=25575
>     server-ip=
>     server-port=25565
>     snooper-enabled=true
>     spawn-animals=true
>     spawn-monsters=true
>     spawn-npcs=true
>     spawn-protection=16
>     texture-pack=
>     view-distance=10
>     white-list=false
> ```

As you can see, the bulk of this file is not yaml, or even meant for k8s: it is a Minecraft `server.properties` file. What's it doing here?

This yaml declares a ConfigMap, which is a read-only form of small storage meant for supplying config data to a pod. The field `server.properties` inside the `data` section is treated as a file name, and everything after the pipe is considered the contents of that file. We can mount this ConfigMap in our pods the same way we mount a PVC.

But watch out! Files specified in a ConfigMap are read-only. As it turns out, the Minecraft server process attempts to write to this file on startup. We'll do some tomfoolery to work around this in the next step, the Deployment.