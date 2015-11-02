### Promise Bundle

The promise bundle is one of the basic building blocks of configuration
in CFEngine.

A promise bundle is a group of one or more logically related promises.

The bundle allows us to group related promises, and to refer to such
groups by name.

You can group promises into bundles in the way that makes the most
sense for your environment and team.

For example:

- *base_os_config* bundle contains promises to configure the base OS,

- *httpd* bundle contains promises to install and configure Apache httpd,

- *inventory_java_mem* contains promises to collect information about Java memory settings (starting and max memory size) used to ensure legacy hosts for the same applications have the same settings.


Bundles always have a type which must be specified when you declare a bundle.

The type corresponds to a specific CFEngine component which handles those promises.

| Bundle     | Contains promises for |
|------------|-----------------------|
| `agent`    | *cf-agent*, the part of CFEngine that checks and repairs system state
| `edit_xml` | *cf-agent* promises about file contents when they are structured data (XML)
| `edit_line`| *cf-agent* promises about file contents when they are unstructured data (everything else)
| `monitor`  | *cf-monitord*, the system monitoring component installed on every host
| `server`   | *cf-serverd*, the policy/file server component - usually ACL promises
| `common`   | Any CFEngine component - usually used to define variables and to classify systems (group hosts by type). More on classification in Chapter 4.

Bundles consist of the keyword `bundle` followed by bundle type and name, followed by curly braces that enclose the promises, e.g.:

```cfengine3
bundle agent my_example
{

...  # your promises code goes here

}
```

Notice our syntax highlighter puts language keywords in green.
