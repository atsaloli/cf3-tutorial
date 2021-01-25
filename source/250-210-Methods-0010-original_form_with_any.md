Up until CFEngine 3.7, methods promises had the standard promise
form, complete with promiser, but the promiser didn't do anything:


```cfengine3
methods:

  "any"

    usebundle => my_bundle_name;
```

The author of CFEngine said to put "any" for the promiser for now,
and that the promiser was reserved for future development.
