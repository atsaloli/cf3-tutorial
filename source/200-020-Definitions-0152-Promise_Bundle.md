#### Bundle Type

Bundles always have a type which must be specified when you declare a bundle.

The type corresponds to a specific CFEngine component which handles those promises.

| Bundle     | Contains promises for |
|------------|-----------------------|
| `agent`    | *cf-agent*, the part of CFEngine that checks and repairs system state
| `edit_xml` | *cf-agent* promises about file contents when they are structured data (XML)
| `edit_line`| *cf-agent* promises about file contents when they are unstructured data (everything else)
| `monitor`  | *cf-monitord*, the system monitoring component installed on every host
| `server`   | *cf-serverd*, the policy/file server component - usually ACL promises
| `common`   | Any CFEngine component - usually used to define variables and to classify systems (group hosts by type)

