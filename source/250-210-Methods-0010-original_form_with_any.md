Up until CFEngine 3.7, methods promises had the standard promise
form, complete with promiser, but the promiser didn't do anything,
it was there just to stick to the standard form of a promise.
The author said to put "any" there and that the promiser was reserved
for future development:

```cfengine3
methods:

  "any"

    usebundle => my_bundle_name;
```

