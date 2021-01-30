#### Parsing JSON with jq

You can use `jq` to query JSON data.

##### Installing jq

On RHEL 7, use the latest Fedora EPEL repo to install `jq`.

References:
* https://stedolan.github.io/jq/

##### Using jq to parse CFEngine syntax document

Example of using jq -- list all available promise types:

```console
$ cf-syntax | jq '.promiseTypes | keys' | head
[
  "access",
  "build_xpath",
  "classes",
  "commands",
  "databases",
  "defaults",
  "delete_attribute",
  "delete_lines",
  "delete_text",
...
```
