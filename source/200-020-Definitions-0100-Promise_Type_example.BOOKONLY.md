The promise type is always followed by a single colon.


```cfengine3, options:  "hl_lines": [1]
files:    

    "/etc/nologin" 

        create  => "true",
        comment => "Prevent non-root users from logging in";
```
