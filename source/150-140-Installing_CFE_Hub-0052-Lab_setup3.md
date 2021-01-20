#### Roll Your Own Lab

##### Operating System

CFEngine is multiplatform.
The examples in this collection have been tested on RHEL 8.

If you're not sure what OS to install on your VMs, we recommend you
install the same OS as you use in production and let us know if you have
any trouble.

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
