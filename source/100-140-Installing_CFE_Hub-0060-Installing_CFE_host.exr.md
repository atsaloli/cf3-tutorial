Installing CFEngine on your 2nd VM (the managed host)

- Ensure your Host VM has an FQDN hostname.
```bash
vi /etc/hosts
/bin/hostname <hostname.domain>
```

- Download host package.
```bash
wget https://cfengine-package-repos.s3.amazonaws.com/enterprise/Enterprise-3.7.1/\
agent/agent_rhel6_x86_64/cfengine-nova-3.7.1-1.x86_64.rpm
```

- Install host package.
```bash
rpm -ihv ./cfengine-nova-3.7.1-1.x86_64.rpm
```

- Bootstrap the host to the hub:
```bash
cf-agent -B <hub IP address>
```

- Go to hub admin UI and within 5-10 minutes the hosts indicator at the top should go from 1 to 2.
