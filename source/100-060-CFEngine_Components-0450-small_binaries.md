### A Note on Size

The CFEngine agent is a small C binary. The other components are even smaller C binaries.

```console
$ ls -lh /var/cfengine/bin/cf-* |
> awk '{print $NF, $5}' | sort | column -t
/var/cfengine/bin/cf-agent     1.8M
/var/cfengine/bin/cf-check     710K
/var/cfengine/bin/cf-execd     160K
/var/cfengine/bin/cf-key       84K
/var/cfengine/bin/cf-monitord  448K
/var/cfengine/bin/cf-net       73K
/var/cfengine/bin/cf-promises  53K
/var/cfengine/bin/cf-runagent  69K
/var/cfengine/bin/cf-serverd   472K
/var/cfengine/bin/cf-upgrade   68K
$
```

