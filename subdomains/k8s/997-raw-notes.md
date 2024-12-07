you can't specify a port range in a service or deployment :(

strategy: recreate, the alternative is rollingupdate. recreate kills all pods in the deployment before recreating any when you replace

update nodeport range: involves adding a flag to a systemd service unit and reload+restarting service...presumably on each host. sounds ansibleable. https://github.com/k3s-io/k3s/issues/444 see last update. fixed by reinstalling the cluster lol

i've updated both controllers' service units and restarted k3s on each. recreating the service still fails because 9009 is outside of 30000-32767

https://k8syaml.com/

pod won't start? it shows an event complaining about the longhorn volume being in use by the system so can't mkfs? https://longhorn.io/kb/troubleshooting-volume-with-multipath/ you need to add the blacklist line (not one line---must be all three separately) to /etc/multipath.conf. on which nodes? idk. just do them all. ansible!