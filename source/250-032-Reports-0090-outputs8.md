##### Recap

The output from each agent run is in `/var/cfengine/outputs/`.

CFEngine updates the `previous` symlink to point at the most recent run.

`/var/cfengine/promise_summary.log` records _when_ the agent ran and and the _outcome summary_ for each run.
