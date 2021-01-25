CFEngine arrays are associative (hashes).

They may contain scalars or lists as their elements.

Array variables are written with '[' and ']' brackets:

```cfengine3
$(array_name[key_name])
```

or

```cfengine3
$(bundle_name.array_name[key_name])
```

