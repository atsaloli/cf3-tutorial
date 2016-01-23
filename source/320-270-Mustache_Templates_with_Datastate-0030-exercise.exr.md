Make a Mustache template that accesses CFEngine datastate

* Make a mustache template that accesses variables from CFEngine datastate

Create /etc/motd from a Mustache template that includes the host name,
time of last run, and time of last policy update.

E.g.:

```bash
$ cat /etc/motd
*** Unauthorized Use Forbidden ***

Welcome to apple.example.com

This system is managed by CFEngine.
Last CFEngine policy update: Thu Nov  5 19:22:02 GMT 2015
Last CFEngine run: Thu Nov  5 19:22:03 GMT 2015
$
```

* Make a mustache template that accesses classes from CFEngine datastate

Make /etc/motd say "Welcome to a Linux system" if the CFEngine linux "class" is set.


