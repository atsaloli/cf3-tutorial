### Populating from Datastate

Function `datastate()` returns a data container with the current evaluation data state (all the classes and variables in cf-agent memory).

The returned data container will have the keys `classes` and `vars`.

Under `classes` you'll find a map with the class name as the key and `true` as the value.

Under `vars` you'll find a map with the bundle name as the key. Under the bundle name you'll find another map with the variable name as the key.


Definition:

**dictionary** (also known as map)
: An abstract data type storing items, or values. A value is accessed by an associated key.  
https://xlinux.nist.gov/dads/HTML/dictionary.html
