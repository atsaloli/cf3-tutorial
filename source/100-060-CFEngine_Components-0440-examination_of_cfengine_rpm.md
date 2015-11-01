### Inspect Package of the CFEngine Core

- Download Core package:

```bash
wget https://cfengine-package-repos.s3.amazonaws.com/community_binaries/\
cfengine-community-3.7.1-1.el6.x86_64.rpm
```
or download from [CFEngine](https://cfengine.com/product/community/)

- Examine Core package:

```bash
rpm -q --filesbypkg cfengine-community-3.7.1-1.el6.x86_64.rpm | less
```
