Install CFEngine on your Hub VM

- Ensure your Hub VM has an FQDN hostname (required by Hub package)

  - Add line for FQDN hostname, e.g. "1.2.3.4 alpha.example.com"

```bash
vi /etc/hosts
```
  - Set hostname to FQDN:

```bash
/bin/hostname alpha.example.com
```

- Download hub package

```bash
wget https://cfengine-package-repos.s3.amazonaws.com/enterprise/\
Enterprise-3.7.1/hub/redhat_6_x86_64/cfengine-nova-hub-3.7.1-1.x86_64.rpm
```

If the above URL stops working, you can download the hub package
from [CFEngine.com](http://cfengine.com/download/)

- Install the hub package.

```bash
rpm -ihv ./cfengine-nova-hub-3.7.1-1.x86_64.rpm
```

- Bootstrap the hub to itself:

```bash
cf-agent -B <hostname>
```

NOTE: Bootstrapping performs a key exchange to establish a trust
relationship so that the host can download policy updates from
the hub, and the hub can download inventory and compliance reports
from the host.

- Login to hub admin UI over HTTPS (admin/admin) 

- Change the admin UI password so the VM doesn't get compromised
(Admin -> Settings -> User Management -> Change password)
