##### Network Access

The VMs need to be able to get out to the Internet to install
packages.

Ensure your VMs have Internet access:

```bash
ping google.com
```

Some companies allow Internet access only through proxies in Web
browser. You will need access from the command line.

Your systems also need to be able to reach each other on tcp/5308
(CFEngine).
