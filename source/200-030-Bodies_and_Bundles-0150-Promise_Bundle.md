### Promise Bundle

**Promise bundle**
: A promise bundle is a group of one or more logically related _promises_.

The bundle allows us to group related promises, and to refer to such
groups by name.

You can group promises into bundles in the way that makes the most
sense for your environment and team.

For example:

- `base_os_config` bundle contains promises to configure the base OS,

- `httpd` bundle contains promises to install and configure Apache httpd,

- `inventory_java_mem` contains promises to collect information about
Java memory settings (starting and max memory size) used to ensure legacy
hosts for the same applications have the same settings (actual example).

