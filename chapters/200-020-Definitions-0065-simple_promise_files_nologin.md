### Example simple promise - create a file

```cfengine3
files:

    "/etc/nologin" 

        create  => "true",
        comment => "Prevent non-root users from logging in so we can perform maintenance";
```
