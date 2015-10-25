### Running the Examples: Inform Mode

We recommend adding *-I* to turn on Inform mode, to inform of
changes made to the system.  By default CFEngine won't inform of changes
as reports at scale (e.g. tens of thousands of systems) can be overwhelming.
However, while learning, it's educational to know when CFEngine makes changes
and what those changes are.

Example:

```bash
cf-agent -I -f ./create_file.cf
```
