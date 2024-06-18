---
title: 380-maintenance
date: 2024-06-16
authors:
  - juh
prev: 350-service
---
# Expanding storage

I did promise we could expand our PV. Here's how:

```sh
kubectl edit -n mcd pvc smp-164-pvc`
```

- `-n mcd`: look in the `mcd` namespace
- `pvc`: we're looking for a PVC kind of resource
- `smp-164-pvc`: the name of the PVC

Find the field `spec.requests.resources.storage` and upgrade the size to whatever. Save and quit. We've upgraded our _request_, but that doesn't mean the backing volume is expanded yet. For that to happen, we need to unmount the volume:

```sh
kubectl scale -n mcd deployment smp-164-deployment --replicas 0
```

Scale the deployment down to zero replicas, or zero pods. The volume will be unmounted since there's no one to mount it. Let it breathe for a couple of minutes, and check up on it:

```sh
watch kubectl get -n mcd pvc
```

Check whether the `CAPACITY` column reports your new size yet. When it does, scale the deployment back up to `--replicas 1`.

# Connecting to the Longhorn UI (and port forwarding in general)

Longhorn exposes a web UI. You can connect to it without exposing it to the internet:

```sh
kubectl port-forward -n longhorn-system svc/longhorn-frontend 8000:80
```

Now browse to http://localhost:8000/ and browse your available cluster storage. You can apply this approach to other things probably!

# Debugging a container from the inside

Kubernetes offers a facility similar to `docker exec`, which allows you to spawn a new process inside a running container:

```sh
kubectl -n mcd smp-164-deployment-12345678gibberish-5more -it -- sh
# or more generally
kubectl -n <namespace> <pod name> [-c <ct name>] <options> -- <process invocation>
```

You can find the pod name like so:

```sh
kubectl -n mcd get pods
```

Use the `-c` option if you care which container you're running the process in, if the pod has more than one. You can omit it if there's just one; k8s will choose it as the default.