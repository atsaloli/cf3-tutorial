### First VM -- the Hub

TODO - this needs to be updated for 3.12 or newer

- Ensure your Hub VM has an FQDN hostname (required by Hub package).
Add line for FQDN hostname, e.g. "1.2.3.4 alpha.example.com"

```bash
vi /etc/hosts
```
Set hostname to FQDN:

```bash
/bin/hostname alpha.example.com
```
