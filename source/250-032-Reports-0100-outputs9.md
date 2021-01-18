Now let's check syslog log file:

```console
# grep cf-agent /var/log/syslog | tail
Nov  7 21:36:32 ubuntu [96961]: CFEngine(agent) 
  Q: ".../bin/date": Sat Nov  7 21:36:32 PST 2015

Nov  7 21:36:32 ubuntu [96961]: CFEngine(agent) 
  R: hello world

Nov  7 21:41:35 ubuntu [97148]: CFEngine(agent) 
  Q: ".../bin/date": Sat Nov  7 21:41:35 PST 2015

Nov  7 21:41:35 ubuntu [97148]: CFEngine(agent) 
  R: hello world

Nov  7 21:46:37 ubuntu [109436]: CFEngine(agent) 
  Q: ".../bin/date": Sat Nov  7 21:46:37 PST 2015

Nov  7 21:46:37 ubuntu [109436]: CFEngine(agent) 
  R: hello world
```

Note: On Red Hat systems, check /var/log/messages.
