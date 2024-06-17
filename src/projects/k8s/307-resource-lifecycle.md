---
title: 307-resource-lifecycle
date: 2024-06-16
authors:
  - juh
prev: 305-yaml-structure
next: 310-namespace
---
# What are resources? Where do they come from? Where does all this yaml go?

Kubernetes is administered declaratively. You can run some imperative commands against a cluster, but they end up being translated to changes in declarations anyways. You declare what resources you want to see, and then the various machinations of The Cloud do what they can to bring the working state of the cluster into alignment with what you've asked for. We describe a resource using YAML, then send it off to the cluster for processing. You keep a copy of all the yaml you've written locally, and the cluster keeps a working copy of everything you've told it to be.

The workflow I've been using looks like this:

1. Create a directory on your laptop/dev machine/wherever you want to work from (not a server in the cluster!) to hold the project. Work exclusively from this directory. It's not that working from a member of the cluster is dangerous (as far as I know), it's just not necessary. I prefer to write it up on my laptop and kubectl sends everything to the cluster just fine.
2. In our local working directory, write the yaml that defines a resource.
3. Create the resource in the cluster: `kubectl create -f my-resource.yaml`. If you want to operate on all the yaml files in the directory, use `-f .`. If you want to operate on a subset of them, you'll need to use `-f` once per file (i.e., no `*` here).
4. To test some small changes to the deployment, run `kubectl replace -f 30-deployment.yaml`, or `kubectl delete -f 30-deployment.yaml` followed by `kubectl create -f 30-deployment.yaml`. (or whatever file you're testing, but be thoughtful about which things depend on whatever resource you're replacing, and whether you'll see the results of the experiment you meant to execute)
5. To test the entire setup end to end, delete everything (`kubectl delete -f .`) and recreate it all (`kubectl create -f .`).

Here are the operations you'll likely use throughout this series:

- C: `kubectl create`: given a resource definition file (`-f my-resource.yaml`), tell the cluster to set that thing up. The cluster now has a copy somewhere of the yaml you just fed to it.
- R: `kubectl get`: briefly list resources. e.g.: `kubectl get -n mcd pods`, `kubectl get -n mcd svc` 
- U: `kubectl edit`: given a pointer to an existing resource (e.g. `kubectl edit namespace mcd`), open the cluster's copy of the yaml (read: the running configuration) to edit in $EDITOR. Write and quit to commit changes to the live cluster. k8s will attempt to validate your changes and may complain; if this happens, I think the changes are rejected. I hope.
- U: `kubectl replace`: overwrites the cluster's copy of a resource definition with the file you specify (`-f`). I think matching up which resource is which is done with namespace and name, which would make sense, but I'm not 100% sure. Could verify by changing the `name` attribute locally and seeing if it fails or creates a new resource or what.
- D: `kubectl delete`: given a file (`-f`), delete the resource that it describes from the cluster's running config. The file will remain on your local machine. See notes in previous bullet about how k8s determines which thing you want to change.
- `kubectl exec`: similar to `docker exec`, specify a namespace (`-n`) and a pod name, then some other stuff (usually `-it -- sh` to get a shell) to execute a command in a pod.
- `kubectl scale`: change the number of replicas in a deployment. we won't really use this here but it sounds important

Here are the common options you'll see used across various kubectl commands:

- `-f {<filename>.yaml | .}` identifies a file to operate with. Use the name of a directory (such as `.`) to reference all yaml files in the directory. I think it'll pick up both `.yaml` and `.yml`. Convention seems to be to prefer `.yaml` with k8s.
- `-n <namespace>` specifies a namespace to operate in. We won't use this much with `create`, `replace`, and `delete` because our files indicate what namespace to work in (see [310-namespace](310-namespace)), but we will need this for `edit`, `get`, `exec`, `scale`, anything where the namespace isn't defined in a given file (or there is no file to give).

# What is a pod?

You can think of a pod as a VM with docker in it. A pod can contain several containers, mount several filesystems or volumes, and share disks and network resources among its containers. Everything inside a pod is guaranteed to run together on the same "node" (basically, same physical host). Multiple pods within a deployment, however, may be scheduled to run on different nodes.

The more I think about it, the less this makes sense. Each _container_ actually has its own filesystem, but the pod has a collection of other volumes you can mount in the container. But I think maybe it still holds up for the most part for the rest of the stuff? I dunno!