#### Example of Promise Body

The last three lines constitute the promise body.

```cfengine3
files:

    "/var/cfengine/i_am_alive"

        create  => "true",
        touch   => "true",
        comment => "Prove CFEngine is running.";
```
