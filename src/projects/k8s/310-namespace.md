---
title: 310-namespace
date: 2024-06-16
authors:
  - juh
prev: 307-resource-lifecycle
next: 320-pvc
---
> [!file]+ 10-ns.yaml
> ```yaml
> apiVersion: v1
> kind: Namespace
> metadata:
>   name: mcd
> ```

We start by creating a namespace for our project to live in. There is a `default` namespace that stuff will go in otherwise, but we would rather not do that, because things will get messy fast when you have more than one project. Using namespaces has no performance overhead (probably since the alternative is using the default namespace anyways), and can [improve performance](https://cloud.google.com/blog/products/containers-kubernetes/kubernetes-best-practices-organizing-with-namespaces) since there's less for the system to look through for a given request.

When writing up the rest of your resources, you can add a `namespace` field to the `metadata` section to have it automatically put into the given namespace. If you choose to omit that field, you can also specify the namespace on the command line with the `-n` option: `kubectl -n mcd ...`

