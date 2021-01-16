### Small Binaries

The CFEngine binaries are small:

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

CFEngine is very lightweight. This is how it's so fast and can be run frequently to monitor and maintain infrastructure health.
