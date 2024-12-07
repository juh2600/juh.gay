---
title: 303-tools
date: 2024-06-16
authors:
  - juh
prev: 301-raw-notes
next: 305-yaml-structure
---
# Nice stuff to have

Try `kubectl completion` to generate command completions for your shell (mine supports bash, zsh, fish, powershell). I also alias `kubectl` to `kc` for ease of typing, but I'll try to spell it out for these articles.

I use [Infra](https://infra.app/download) to view what the cluster is doing while it's doing it. It's a GUI application (Electron, I think) that updates in either real time or close to it, and lets you browse resources and logs. I have the basic free version.

[`k9s`](https://k9scli.io/topics/install/) is a TUI option for inspecting the state of a cluster, though I can't speak to its features because I'm not using it.

To get [Longhorn](https://longhorn.io/docs/1.6.2/deploy/install/install-with-helm/) installed (currently not discussed) you'll probably want [Helm](https://helm.sh/docs/intro/install/) (also not discussed), which also offers `helm completion`. -- On revisiting Longhorn's site, they have an option that [uses kubectl](https://longhorn.io/docs/1.6.2/deploy/install/install-with-kubectl/) instead, which makes things even simpler.

I actually built this example based on the output of `kompose convert` run against a known-good docker-compose.yml setup. It's a pretty good starting point, just needs some cleanup to make it more human-readable and then tweaking to make it what you really want. Grab a copy of the binary per [their instructions](https://kompose.io/installation/) and slap it in `/usr/local/bin/`. Do _not_ install it as a Snap package---that never worked right for me. sigh.