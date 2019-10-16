### Running the Examples: Inform Mode

By default, CFEngine doesn't inform you of changes it makes as reports at scale (e.g. tens of thousands of systems) can be overwhelming.

However, while learning, it's educational to know when CFEngine makes changes
and what those changes are.

You can use the `-I` switch to turn on Inform mode so that CFEngine informs of
changes it makes to your system:

Example:

```bash
cf-agent -I -f ./create_file.cf
```
