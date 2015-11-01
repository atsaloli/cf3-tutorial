## Edit /etc/motd (file editing and classes)

Part 1

* Write a policy to create '/etc/motd' as follows:

It should *always* say "Unauthorized use forbidden."

Part 2

* '/etc/motd' should *always* say "Unauthorized use forbidden". However, on weekends, it should also say "Go home, it's the weekend".

Test by defining "Saturday" class on the command line:

```bash
cf-agent -D Saturday  --file ... --bundle ...
```
