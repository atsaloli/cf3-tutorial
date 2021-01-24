**list**
: A data structure holding many values --- Free On-Line Dictionary of Computing

In CFEngine syntax, lists are in curly braces and 
are a collection of comma-separated scalar values.
For example:

```cfengine3
processes:
    "cupsd"
        signals => { "term", "kill" };
```
