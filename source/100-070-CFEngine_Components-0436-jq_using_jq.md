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
