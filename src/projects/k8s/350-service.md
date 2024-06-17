---
title: 350-service
date: 2024-06-16
authors:
  - juh
prev: 340-deployment
next: 380-maintenance
---
> [!file]+ 40-service.yaml
> ```yaml
> apiVersion: v1
> kind: Service
> metadata:
>   name: smp-164-svc
>   namespace: mcd
> spec:
>   type: NodePort
>   selector:
>     app: mcd
>   ports:
>     - name: mc
>       port: 25565
>       targetPort: 25565
>       nodePort: 32565
>       protocol: TCP
> ```

The Service exposes ports from a Deployment (`port`) to other things, whether that's other resources internally (`targetPort`) or the external network (internet, LAN, whatever) (`nodePort`). Because of the woke, you can't by default expose a `nodePort` outside of 30000--32767. You can configure it otherwise, but I couldn't be bothered to figure out how at the moment, and I'm not sure whether that's a good idea or not. Luckily for us, Minecraft supports the DNS `SRV` record!

```
mc.example.org. 300 IN A 1.2.3.4
_minecraft._tcp.example.org. 300 IN SRV 0 0 32565 mc.example.org.
```

This will tell the client what address and port to use for the Minecraft server at `example.org`. If you don't own that domain, you'll have to use a different one.

Because an [Ingress is designed for HTTP traffic](https://kubernetes.github.io/ingress-nginx/user-guide/exposing-tcp-udp-services/), we won't use one here, since this is Minecraft and not a web service. (Yes, the article says that there's an ingress controller that can handle TCP and UDP, but the point is that they're not meant for that.)

If I'm reading this right, I think you can use one Service to expose ports from multiple different Deployments in the same namespace. As long as the deployments (pods?) match the `selector` criteria (here, having the label `app: mcd`), it seems they're eligible to serve as the back end of this service.