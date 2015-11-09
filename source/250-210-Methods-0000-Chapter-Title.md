## Methods

These are promises to take on a whole other bundle of promises.

They may be parameterized.

Up until CFEngine 3.7, methods promises had the standard promise
form, complete with promiser, but the promiser didn't do anything,
it was there just to stick to the standard form of a promise, so
the CFEngine document just put "any" there and said that the
promiser was reserved for future development:

```cfengine3
methods:

  "any"

    usebundle => my_bundle_name;
```

The community started to use the promiser field of `methods` promises
to summarize/document what the called bundle was doing in human-readable
format, e.g.:


```cfengine3
methods:

  "Configure NTPD"

    usebundle => ntpd;
```

As of CFEngine 3.7, the promiser can be used to provide the name
of the bundle to take on and the `usebundle` attribute can be 
omitted, e.g.:


```cfengine3
methods:

  "ntpd";

```
