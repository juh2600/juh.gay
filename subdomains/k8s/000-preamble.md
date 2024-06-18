---
title: 000-preamble
date: 2024-06-16
authors:
  - juh
next: 300-mwe
---
# Prerequisites

This series presumes comfort with containers and basic container orchestration (my experience is primarily through use of [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/)). If you can answer the question "Why is storage a unique challenge for containerized workloads?", you're probably ready on the container front. I may write an intro to containerization at some point in the future.

This series also presumes some vague knowledge of what Kubernetes is for (but not how to use it, obviously). If you can answer the question "What is Kubernetes for?", you'll probably be okay. ;)

We also presume that you have a running Kubernetes cluster with Longhorn installed at your disposal. I recognize that that is not exactly a trivial ask (though, it's not that bad either). Take a look at [k3sup](https://github.com/alexellis/k3sup) and the [Longhorn docs](https://longhorn.io/docs/1.6.2/deploy/install/install-with-kubectl/).

# Why this series

I've spent a few months (on and off) trying to wrap my head around k8s and what it takes to deploy a service. Both of those words will soon have specific meanings and this sentence will no longer make sense, which is part of the problem. The other problem is that all the guides and tutorials I find seem to focus more on your "emotional" understanding of pods, deployments, services, persistent volume claims, storage classes... not "here's what you need to deploy a service end to end". It's always snippets, never a full example. I often learn best by starting with a working example, adapting it to my needs, breaking it, studying what broke, changing it to see what these other settings I found would do, but you can't do that if you don't know if you have the whole example or not. I finally figured out how to cobble together a working service (a Minecraft server), and I want to help anyone who's looking for an end to end example like I have been.

I may not write this all in chronological order, though. My focus right now is everything from "cluster is already set up with longhorn installed" to "I can log in to minecraft", since I got that all working last night. But in the spirit of e2e, I feel like I ought to document the process of setting up the cluster and installing Longhorn for storage. I might work on those later.

I may at some point write another series, or expand this one, to include some of the current non-goals---specifically, I do wish to set up web services with TLS, and I do wish to master the concept of an Ingress. I'm not there yet, though.

# Goals

- Provide and explain a full working example of deploying a single instance of a Minecraft server on a Kubernetes cluster, including first-time initialization of settings and persistent, expandable storage.
- Explain the pitfalls I discovered along the way, that the reader may either avoid them, recognize them, or explore them further.

# Non-goals

- Explain every possible way to set up a service on Kubernetes.
- Explain how to build or use an Operator, or a [Helm](https://helm.sh/docs/intro/install/) chart.
- Explain the use of an Ingress, or how to serve Web services over standard ports.
- Explain how to set up a cluster or install Longhorn.
- Do anything with auto-generated TLS certs.
- Explain how to configure DNS.