
The promiser follows the promise type, and is in double quotes.

```cfengine3, options:  "hl_lines": [3]
files:

    "/etc/nologin"  

        create  => "true",
        comment => "Prevent non-root users from logging in";
```
