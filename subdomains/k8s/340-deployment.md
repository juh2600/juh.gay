---
title: 340-deployment
date: 2024-06-16
authors:
  - juh
prev: 330-configmap
next: 350-service
---
> [!file]+ 30-deployment.yaml
> ```yaml
> apiVersion: apps/v1
> kind: Deployment
> metadata:
>   name: smp-164-deployment
>   namespace: mcd
>   labels:
>     app: mcd
>     style: smp
>     version: 1.6.4
> spec:
>   replicas: 1
>   selector:
>     matchLabels:
>       app: mcd
>       style: smp
>       version: 1.6.4
>   strategy:
>     type: Recreate
>   template:
>     metadata:
>       labels:
>         app: mcd
>         style: smp
>         version: 1.6.4
>     spec:
>       initContainers:
>         - name: init-config-files
>           image: busybox:1.36
>           command: ["/bin/sh", "-c"]
>           args:
>             - |
>               yes n | cp -Lri /tmp/config/. /data/
>           volumeMounts:
>             - mountPath: /data
>               name: smp-164-vol
>             - mountPath: /tmp/config
>               name: smp-164-config
>        #- name: init-compare-files
>        #  image: busybox:1.36
>        #  command:
>        #    - "find"
>        #    - "/data"
>        #    - "/tmp/config"
>        #  volumeMounts:
>        #    - mountPath: /data
>        #      name: smp-164-vol
>        #    - mountPath: /tmp/config
>        #      name: smp-164-config
>        #- name: init-sleep
>        #  image: busybox:1.36
>        #  command:
>        #    - "sleep"
>        #    - "infinity"
>        #  volumeMounts:
>        #    - mountPath: /data
>        #      name: smp-164-vol
>        #    - mountPath: /tmp/config
>        #      name: smp-164-config
>       containers:
>         - name: smp-164
>           image: itzg/minecraft-server
>           stdin: true
>           tty: true
>           ports:
>             - containerPort: 25565
>               hostPort: 25565
>               protocol: TCP
>           volumeMounts:
>             - mountPath: /data
>               name: smp-164-vol
>           env:
>             # things the ct won't run without
>             - name: EULA
>               value: "true"
> 
>             # jvm options
>             - name: INIT_MEMORY
>               value: 1G
>             - name: MAX_MEMORY
>               value: 3G
>             - name: JVM_XX_OPTS
>               value: -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=50 -XX:+AlwaysPreTouch -XX:+UseLargePages -XX:LargePageSizeInBytes=2m
> 
>             # game info
>             - name: TYPE
>               value: VANILLA
>             - name: VERSION
>               value: 1.6.4
> 
>             # game server options
>             - name: ENABLE_ROLLING_LOGS
>               value: "true"
>             - name: TZ
>               value: America/Vancouver
> 
>       restartPolicy: Always
>       volumes:
>         - name: smp-164-vol
>           persistentVolumeClaim:
>             claimName: smp-164-pvc
>         - name: smp-164-config
>           configMap:
>             name: smp-164-config
> ```

This is where the magic happens. Let's start from the top.

# Preamble

```yaml
apiVersion: apps/v1
kind: Deployment
```
`
# Metadata

```yaml
metadata:
  name: smp-164-deployment
  namespace: mcd
  labels:
    app: mcd
    style: smp
    version: 1.6.4
```

Name and namespace should be pretty familiar by now. Even though we're not managing a complex deployment here, I applied a few labels to help identify what this particular service is: it's a minecraft daemon (`mcd`), configured for survival multiplayer (`smp`), running version `1.6.4`. This way, we can grep for things in the future based on any of those dimensions and see what we have running in the field. I probably should have also added a label like `track: vanilla` to help differentiate from Paper and the like.

Note that these labels are applied to the _Deployment_ resource itself, not the pod(s) in the deployment.

```yaml
spec:
  replicas: 1
```

This deployment should be running one (1) replica: just a single instance of the server. If we were running a major web service, we would probably want to run many replicas to help distribute the load across machines.

```yaml
  selector:
    matchLabels:
      app: mcd
      style: smp
      version: 1.6.4
```

How do we know if we're running the right number of replicas? Look for pods with these labels and count them up. Note! We just saw these labels a minute ago, but they are _not_ the ones we're matching against! (I think!) They just happen to be identical because the scope of this deployment is very limited, and I'm a noob and don't know how to choose useful labels yet. I'm pretty sure these are compared with the labels that apply to _Pods_, which we'll define a couple of blocks from now.

```yaml
  strategy:
    type: Recreate
```

Dunno.

```yaml
  template:
```

From here on down, we describe a pod.

```yaml
    metadata:
      labels:
        app: mcd
        style: smp
        version: 1.6.4
```

Here are those pod labels we talked about. If I've got this right, these are how the deployment controller knows when to spin up more pods.

```yaml
    spec:
      initContainers:
```

A pod can run multiple containers, but it can also run _init containers_. These run to completion before the job containers start. This is how we can configure the pod (remember, it's basically a VM with a filesystem and stuff) to be just right for the actual server(s) to run in.

```yaml
        - name: init-config-files
          image: busybox:1.36
          command: ["/bin/sh", "-c"]
          args:
            - |
              yes n | cp -Lri /tmp/config/. /data/
          volumeMounts:
            - mountPath: /data
              name: smp-164-vol
            - mountPath: /tmp/config
              name: smp-164-config
```

In our case, remember how the config map is read-only but we need to write to it? Here's the solution: Mount the volume and the config map in an init container, and copy everything out into the volume. Busybox's cp's `-n` flag doesn't seem to work ("don't overwrite", or "no clobber"), but we can emulate it with `yes n | cp -i`. I learned that `cp foo/. bar/` lets you copy everything from inside of `foo/` to inside of `bar/` without creating `bar/foo/`. Note that the `name`s in the `volumeMounts` section are _not_ the names we supplied in the yaml to define the PVC and config map! Instead, they are (once again) declared later on in this file (at the end).

By the way, the reason we need something like `cp -n` is because these init containers will run every time the pod is spun up. If we've shut down the server for a bit and want to start it back up, the server will have made its own changes to the config files, and we don't want to overwrite those. `-L` is because the config map doesn't just mount a file straight up, it's a link to a file in a directory that's a link to another directory that has the actual file in it. I kept the `-r` because there are other config files we could put in there if we wanted them copied into a clean server as well, such as a list of users to grant op powers.

```yaml
       #- name: init-compare-files
       #  image: busybox:1.36
       #  command:
       #    - "find"
       #    - "/data"
       #    - "/tmp/config"
       #  volumeMounts:
       #    - mountPath: /data
       #      name: smp-164-vol
       #    - mountPath: /tmp/config
       #      name: smp-164-config
```

It took a lot of trial and error to learn that tidbit about `-n`. I added a couple more init containers that run after the cp happens so that I could inspect the results before starting the server. This one prints the contents of the destination and the source to stdout, which appears in the pod's logs that I can view in Infra.

```yaml
       #- name: init-sleep
       #  image: busybox:1.36
       #  command:
       #    - "sleep"
       #    - "infinity"
       #  volumeMounts:
       #    - mountPath: /data
       #      name: smp-164-vol
       #    - mountPath: /tmp/config
       #      name: smp-164-config
```

Another trick I learned: if you have a pod that's crashing, you can't `exec` to get a shell in it if it's stopped. We can set up a job that [sleeps forever](https://stackoverflow.com/a/62099250/6627273) to keep the pod alive, then `exec` into a shell in this init container and poke around the filesystem ourselves to see what happened (and run our own experiments).

```yaml
      containers:
        - name: smp-164
          image: itzg/minecraft-server
          stdin: true
          tty: true
```

Finally! Let's configure the actual server container. Give it a name, an image, tell it to expose stdin and tty because it runs a CLI, normal stuff you'll recognize from Docker Compose.

```yaml
          ports:
            - containerPort: 25565
              hostPort: 25565
              protocol: TCP
```

This should also look familiar, but it's not quite what it seems. This does not expose the container port 25565 as the port 25565 on the node, facing the internet. I think `hostPort` refers to a port on the _pod_ (remember: basically a VM). That's the port that our Service will connect to downstream.

```yaml
          volumeMounts:
            - mountPath: /data
              name: smp-164-vol
```

We don't need the config map anymore since we copied everything out of it, so we won't mount it in the server container. We just need our PVC, and we're gonna mount it at `/data` because that's where the container image wants it.

```yaml
          env:
            # things the ct won't run without
            - name: EULA
              value: "true"

            # jvm options
            - name: INIT_MEMORY
              value: 1G
            - name: MAX_MEMORY
              value: 3G
            - name: JVM_XX_OPTS
              value: -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=50 -XX:+AlwaysPreTouch -XX:+UseLargePages -XX:LargePageSizeInBytes=2m

            # game info
            - name: TYPE
              value: VANILLA
            - name: VERSION
              value: 1.6.4

            # game server options
            - name: ENABLE_ROLLING_LOGS
              value: "true"
            - name: TZ
              value: America/Vancouver
```

This is all stuff specific to the [`itzg/minecraft-server`](https://docker-minecraft-server.readthedocs.io/en/latest/) image. We're setting up these environment variables to pass into the container.

```yaml
      restartPolicy: Always
```

Same as `restart: always` in Docker Compose, probably. Not entirely sure of the implications in k8s or what the other options look like.

```yaml
      volumes:
        - name: smp-164-vol
          persistentVolumeClaim:
            claimName: smp-164-pvc
        - name: smp-164-config
          configMap:
            name: smp-164-config
```

Here we go, this maps the volumes (both the [PVC](320-pvc) and the [ConfigMap](330-configmap)) that we identify by their `kind` and `name`, into names that we can reference when specifying container volumes above. I should probably move this higher up in the file for clarity.