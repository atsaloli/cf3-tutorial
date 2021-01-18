#### Demonstration of handling reports: promises output

Let's demonstrate handling of agent outputs by editing
/var/cfengine/masterfiles/services/main.cf (the default
entry-point to our policy code base) to add promises which generate
output:

```cfengine3
###############################################################################
#
# bundle agent main
#  - User/Site policy entry
#
###############################################################################

bundle agent main
# User Defined Service Catalogue
{
  reports:
    "hello world";

  commands:
    "/bin/date";

  methods:
    # Activate your custom policies here
}
```
