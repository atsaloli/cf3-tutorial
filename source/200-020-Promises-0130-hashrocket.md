What is the `=>` symbol in the promise details?

It is used to specify key/value relationships.


```cfengine3
files:    

    "/etc/nologin" 

        create  => "true",
        comment => "Prevent non-root users from logging in";
```

It is called "hashrocket" in Ruby (because it is used in Ruby hashes),
"fat comma" in Perl, and "double arrow" in PHP.

You can call it whatever you like. :)

Reference:
* <https://en.wikipedia.org/wiki/Fat_comma>
