---
title: 305-yaml-structure
date: 2024-06-16
authors:
  - juh
prev: 303-tools
next: 307-resource-lifecycle
---
You may have noticed some commonalities across the several yaml files in [300-mwe](300-mwe). Let's look at the general structure of a resource in k8s:

> [!config] Sample resource definition
> ```yaml
> apiVersion: v1
> kind: PersistentVolumeClaim
> metadata:
>   name: smp-164-pvc
>   namespace: mcd
>   labels:
>     app: mcd
>     style: smp
>     version: 1.6.4
> spec:
>   ...
> ```

We start with an `apiVersion`. I don't know where these come from; I just copy them from whatever snippet I'm referencing at the time.

Each resource has a `kind`, such as `Namespace`, `Deployment`, `Pod`, `Service`, `Ingress`, `PersistentVolumeClaim`, etc. I guess you could think of these like classes, and then the rest of the file is the initializer for an object, if you want.

Next is the `metadata`, which includes most importantly a `name`. I think these have to look like DNS labels. If you try to use a bad name, it'll let you know when you try to create the resource. You can also include a `namespace`, which we'll discuss more in [310-namespace](310-namespace). Then you can optionally add as many `labels` as you like, which are key-value pairs that are used for grouping/searching/filtering resources, both for human observation and for automated resource management. In other words, you can use these labels to help your system say "ok, we have two versions of this web server, we need at least 5 of them running but we don't care how many of which ones" and it'll say "cool we will spin up 4 more of anything with the `webserver` label and ignore the `version` label, on it". I think that's how it works, but I don't really know yet. I also can't give advice on what/why/when to put different information in the labels, since I haven't used them for anything.

The next top-level section is the `spec`, which defines all the business variables for that `kind` of resource. What all goes in here varies greatly depending on what kind the thing is.