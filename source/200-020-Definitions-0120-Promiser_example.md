### Example of Promiser

'/etc/nologin' is the promiser (the affected system object).

```cfengine3, options:  "hl_lines": [3]
files:

    "/etc/nologin"  

        create  => "true",
        comment => "Prevent non-root users from logging in";
```
