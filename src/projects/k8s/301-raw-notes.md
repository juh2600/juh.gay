---
title: 301-raw-notes
date: 2024-06-16
authors:
  - juh
prev: 300-mwe
next:
---
gui inspector is `infra`

basic PVC setup for longhorn: https://github.com/longhorn/longhorn/blob/master/examples/pod_with_pvc.yaml (btw longhorn creates volumes to back claims automatically it looks like, so don't create a volume and then a pvc)

basic deployment setup: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

how to mount a configmap overlaid on a PVC: https://stackoverflow.com/a/61272839/6627273

configmap lets you inject config files into volumes or pods or whatever: https://kubernetes.io/docs/concepts/configuration/configmap/

you can put metadata.namespace in anything's yaml: https://cloud.google.com/blog/products/containers-kubernetes/kubernetes-best-practices-organizing-with-namespaces

set up nodeport: https://stackoverflow.com/a/58281391/6627273

not an HTTP service so don't do an ingress: https://kubernetes.github.io/ingress-nginx/user-guide/exposing-tcp-udp-services/

server unable to write to /data/server.properties:

```
[init] Running as uid=1000 gid=1000 with /data as 'drwxr-xr-x 3 1000 1000 4096 Jun 15 02:39 /data'
[init] Resolving type given VANILLA
[init] Resolved version given 1.6.4 into 1.6.4
[mc-image-helper] 02:39:52.253 INFO : Created/updated 3 properties in /data/server.properties
[mc-image-helper] 02:39:52.256 ERROR : 'set-properties' command failed. Version is 1.38.16
java.nio.file.AccessDeniedException: /data/server.properties
```

try telling the crashlooping ct to sleep forever so you can exec into it: https://stackoverflow.com/a/62099250/6627273

logging into ct revealed that perms looked good except that /data/server.properties was root:root

problem is maybe that that file was initialized that way by the ConfigMap, and then not changed/erased when ConfigMap was removed from deployment. try recreating the volume. yep that worked

connected to server! mysteriously, generated world appears very similar to the one i got locally. unsure if coincidence or if connection is correct. log out, can't log back in. port is closed.

http://session.minecraft.net/game/joinserver.jsp?<blob\> returned 429 in-game on attempting to connect to k.jtreed.org, after trying jtreed.org (several times) and localhost. waited a bit, got regular "Connection refused" at k.jtreed.org then. probably just rate limited at auth server

`kc get svc -n mcd` reveals that 25565 inside has been mapped to 31468 outside...why? nmap confirms mc is running there

aha! the service config is missing `nodePort`. https://stackoverflow.com/a/61452441/6627273

so targetPort is the port on the ct. port is the port that other internal systems can use. nodePort is the port that external systems can reach

can't set nodeport below 30000 without changing something goofy, so gonna just...use the SVC records! set nodePort to 32565 and configure SRV, and we're in business! also i think the similar world was a coincidence, it appears to be different terrain.

# outstanding questions

how to inject configmap just once maybe? and then let it be rw by server?
scalability, both as independent servers and as a network---SRV records will work, but clunky to set up manually. automate? mux? idk

# continued

okay so we want to initialize the volume with some data but then let it be rw. idea: we can mount the volume and the configmap in an init container (https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-initialization/), then copy (or cat if cp preserves wrong perms) files from map into vol. use cp -n to only copy files that don't already exist, so that we don't overwrite changed properties if the pod restarts

cp's -n flag in busybox 1.28 is nonexistent and 1.32 doesn't work, but you can emulate it with yes n | cp -i. use e.g. cp -r /foo/bar/. /baz/ to copy stuff from inside bar into baz without creating /baz/bar/. but. you can't just write in a piped command like that in the container spec, because it gets taken as a string instead of a redirect lol

try https://stackoverflow.com/a/78309192/6627273 --- it appears this worked! yes it did!

we now have a way to initialize the state of the volume on first turnup, but preserve changes to it across pod restarts or redeployments, as long as the volume is retained.

volume resizing?

- updating the pvc and kubectl replace: no
- scaling deployment down to 0 replicas and then doing replace: no
- deleting the deployment and then replace: no
- `kubectl edit` the pvc (edit the live copy on the server), scale the deployment down to 0r, wait for the volume to expand, then scale deployment back up: yes

the error for the "no"s was:

```
The PersistentVolumeClaim "smp-164-pvc" is invalid: spec: Forbidden: spec is immutable after creation except resources.requests and volumeAttributesClassName for bound claims
  core.PersistentVolumeClaimSpec{
        AccessModes:      {"ReadWriteOnce"},
        Selector:         nil,
        Resources:        {Requests: {s"storage": {i: {...}, s: "5Gi", Format: "BinarySI"}}},
-       VolumeName:       "pvc-f40a28a9-94a3-4e59-8e85-2b876241628d",
+       VolumeName:       "",
        StorageClassName: &"longhorn",
        VolumeMode:       &"Filesystem",
        ... // 3 identical fields
  }
```

despite the fact that the only field we wanted to edit was spec.resources.requests.storage, which should be mutable.