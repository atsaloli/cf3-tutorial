### Example of Promise Type

`files` followed by a single colon indicates the promise type.

The promise type is always followed by a single colon.


```cfengine3, options:  "hl_lines": [1]
files:    

    "/etc/nologin" 

        create  #> "true",
        comment #> "Prevent non-root users from logging in";
```
