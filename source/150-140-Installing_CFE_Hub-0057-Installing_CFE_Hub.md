- Bootstrap the hub to itself:
```bash
cf-agent -B <hostname>
```

- Run the agent once to finish setup:
```bash
cf-agent
```

NOTE: Bootstrapping performs a key exchange to establish a trust
relationship so that the host can download policy updates from
the hub, and the hub can download inventory and compliance reports
from the host.

- Login to hub admin UI over HTTPS (admin/admin)

- Change the admin UI password so the VM doesn't get compromised
(Admin -> Settings -> User Management -> Change password)
