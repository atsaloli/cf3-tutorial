The community started to use the promiser field of `methods` promises
to summarize/document what the called bundle was doing in human-readable
format, e.g.:

```cfengine3
methods:

  "Configure NTPD"

    usebundle => ntpd;
```

