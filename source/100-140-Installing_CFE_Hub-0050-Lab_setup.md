### Lab Infrastructure 
#### Two VMs

To do the exercises, each student should have two VMs:

- one to play the role of the Hub (policy distribution point),
- another to play the role of a managed Host.

Normally, you would have multiple hosts managed from a single hub.
Two VMs gives us a CFEngine-managed system in miniature.

You can use Vagrant or spin them up in the cloud -- your preference.

#### Vagrant

You can follow [CFEngine's Vagrant
guide](https://docs.cfengine.com/latest/guide-installation-and-configuration-general-installation-installation-enterprise-vagrant.html)
to create your lab environment complete with two VMs and the latest
version of CFEngine Enterprise.

#### Operating System

CFEngine is multiplatform.
The examples in this collection have been tested on RHEL 8.

If you're not sure what OS to install on your VMs, we recommend you
install the same OS as you use in production and let us know if you have
any trouble.

#### Network Access

The VMs need to be able to get out to the Internet to install
packages.

Ensure your VMs have Internet access:

```bash
ping google.com
```

Some companies allow Internet access only through proxies in Web
browser. You will need access from the command line.
