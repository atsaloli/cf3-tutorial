We expect to see two entries appear, as
`cf-execd` will run `cf-agent` twice: first to update policy (update.cf)
and then to evaluate the policy (promises.cf):


(I've inserted whitespace for readability, on the console you'd see two
lines only):

```console
1610932105,1610932105: Outcome of version update.cf 3.12.6 (agent-0):
  Promises observed to be kept 100.00%,
  Promises repaired 0.00%,
  Promises not repaired 0.00%
1610932105,1610932106: Outcome of version CFEngine Promises.cf 3.12.6 (agent-0):
  Promises observed to be kept 97.30%,
  Promises repaired 2.70%,
  Promises not repaired 0.00%
```

There are two comma-delimited timestamps (in UNIX epoch format) at the start of each line,
showing start and end of the `cf-agent` run.

You can convert the timestamps to human-readable with `date -d @<timestamp>`.

Subtract the start time from the end time to get how long the agent was running (in seconds).
