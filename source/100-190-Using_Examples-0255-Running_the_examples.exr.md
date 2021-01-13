Inform Mode

Use the `-I` switch to turn on Inform mode so that CFEngine informs of
changes it makes to your system.

Run the "Create File" example with "Inform" mode:

```bash
rm /tmp/test
cf-agent -I -f ./create_file.cf
```

What do you see?
