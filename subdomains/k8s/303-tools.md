---
title: 303-tools
date: 2024-06-16
authors:
  - juh
prev: 301-raw-notes
next: 305-yaml-structure
---
# Document issues

TODO(juh) add hyperlinks to relevant resources, including Infra

# Nice stuff to have

Try `kubectl completion` to generate command completions for your shell (mine supports bash, zsh, fish, powershell). I also alias `kubectl` to `kc` for ease of typing, but I'll try to spell it out for these articles.

I use Infra to view what the cluster is doing while it's doing it. It's a GUI application (Electron, I think) that updates in either real time or close to it, and lets you browse resources and logs. I have the basic free version.

`k9s` is a TUI option for inspecting the state of a cluster, though I can't speak to its features because I'm not using it.

To get Longhorn installed (currently not discussed) you'll probably want Helm (also not discussed), which also offers `helm completion`.

I actually built this example based on the output of `kompose convert` run against a known-good docker-compose.yml setup. It's a pretty good starting point, just needs some cleanup to make it more human-readable and then tweaking to make it what you really want. Install `kompose` from the [k8s github releases page](https://github.com/kubernetes/kompose/releases) and slap it in `/usr/local/bin/`, _not_ as a Snap package---that never worked right for me. sigh.