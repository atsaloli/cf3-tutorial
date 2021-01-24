Wait 5-10 minutes for `cf-execd` to run `cf-agent` during the next scheduled run.
We know when it's done that by watching the promise summary log on the command line:

```console
tail -f /var/cfengine/promise_summary.log
```

The promise summary log contains outcomes for each run of `cf-agent`.

