### Example simple promise - create a file

```cfengine3
files:

    "/etc/nologin" 

        create  => "true",
        comment => "Prevent regular users from logging in
                    during maintenance";
```
