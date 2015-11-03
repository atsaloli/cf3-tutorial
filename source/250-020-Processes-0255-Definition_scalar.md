### Note on Syntax: Single Values vs Lists

Definitions

**scalar**
: (programming) Any data type that stores a single value (e.g. a number or Boolean), as opposed to an aggregate data type that has many elements. A string is regarded as a scalar in some languages (e.g. Perl)  --- Free On-Line Dictionary of Computing

In CFEngine syntax, scalar values are enclosed in double quotes:

```cfengine3
process_stop => "/etc/init.d/cups stop",
```
