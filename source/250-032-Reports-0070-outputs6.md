We expect to see two entries appear, as
`cf-execd` will run `cf-agent` twice: first to update policy (update.cf)
and then to evaluate the policy (promises.cf):

```console
1610932105,1610932105: Outcome of version update.cf 3.12.6 (agent-0):
  Promises observed to be kept 100.00%, Promises repaired 0.00%, Promises not repaired 0.00%
1610932105,1610932106: Outcome of version CFEngine Promises.cf 3.12.6 (agent-0):
  Promises observed to be kept 97.30%, Promises repaired 2.70%, Promises not repaired 0.00%
```

There are two comma-delimited timestamps at the start of each line: start and end times of the `cf-agent` run.

The timestamps are in UNIX epoch format.

You can convert the timestamps to human-readable with `date -d @<timestamp>`.

The delta is how long the agent took to run, in seconds. 

