CFEngine template

1. Manually create a template '/var/cfengine/masterfiles/templates/motd.dat':

```cfengine3
This system is property of __ORGANIZATION__.
Unauthorized use forbidden.
CFEngine maintains this system.
CFEngine last ran on $(sys.date).
```

2. Write a CFEngine policy to generate '/etc/motd' from '/var/cfengine/inputs/templates/motd.dat' as follows:

* Replace __ORGANIZATION__ with the name of your organization.

* Expand the special variable $(sys.date).

Use all of the following promise types:

* delete_lines
* insert_lines
* replace_patterns

