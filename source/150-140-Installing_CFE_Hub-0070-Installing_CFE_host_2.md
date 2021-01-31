- Install host package.
```bash
rpm -ihv ./cfengine-nova-3.7.1-1.x86_64.rpm
```

- Bootstrap the host to the hub:
```bash
cf-agent -B <hub IP address>
```

- Go to hub admin UI and within 5-10 minutes the hosts indicator at the top should go from 1 to 2.
