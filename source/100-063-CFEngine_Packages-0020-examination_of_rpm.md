### Inspect the CFEngine Core Package

#### Download Core package

```bash
wget https://cfengine-package-repos.s3.amazonaws.com/community_binaries/\
Community-3.12.6/agent_rhel8_x86_64/cfengine-community-3.12.6-1.el8.x86_64.rpm
```
or get it from [CFEngine](https://cfengine.com/product/community/)

#### Examine package

Let's examine the package so you can see what gets installed on your system when you install Core.

```bash
rpm -q --filesbypkg cfengine-community-*.rpm | less
```
