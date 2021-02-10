CFEngine daemons

Here is what you typically see between `cf-agent` runs:

```console
$ ps -ef |grep [c]f-
root     807   1  0 Jan26 ?    00:00:34 /var/cfengine/bin/cf-monitord --no-fork
root     833   1  0 Jan26 ?    00:00:13 /var/cfengine/bin/cf-execd --no-fork
root    1367   1  0 Jan26 ?    00:00:08 /var/cfengine/bin/cf-serverd --no-fork
$
```
