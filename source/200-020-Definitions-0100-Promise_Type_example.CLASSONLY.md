The promise type is always followed by a single colon.


```cfengine3
files:    

    "/etc/nologin" 

        create  => "true",
        comment => "Prevent non-root users from logging in";
```
