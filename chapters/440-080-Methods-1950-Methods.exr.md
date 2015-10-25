Configuring a web server.

Write a bundle "webserver" that will ensure an Apache httpd package is installed and process is running if its argument is "on":

```cfengine3
     methods:

        "any"

             usebundle => webserver("on");
```

Then, make sure httpd is not running if its argument is "off".

TIP: The CFEngine function strcmp() can compare two strings.

NOTE: Reference: 039-0085_Basic_Examples:_Classes_and_Reports.__soft-class.cf
