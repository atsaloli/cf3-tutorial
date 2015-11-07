### Make a mustache template that accesses variables from CFEngine datastate

Create the /etc/motd file from a Mustache template that will
include the host name and time.

E.g.:

$ cat /etc/motd
*** Unauthorized Use Forbidden ***

Welcome to apple.example.com

This system is managed by CFEngine.
CFEngine last ran at Thu Nov  5 19:22:03 GMT 2015
$










### Make a mustache template that accesses classes from CFEngine datastate


```text
{{#classes.linux}}
we love linux {{vars.sys.flavour}}
{{/classes.linux}}
```
