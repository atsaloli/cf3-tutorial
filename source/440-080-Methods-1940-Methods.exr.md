Make a bundle called file_contains that takes two arguments: a filename, and a text string.  The bundle should ensure that the file specified in the first argument contains the text string specified in the second argument.

Example:

```cfengine3
    methods:
     "any" usebundle => file_contains("/etc/profile", "export ORGANIZATION=MyOrg");
     "any" usebundle => file_contains("/etc/motd", "Unauth. use forbidden");
```
