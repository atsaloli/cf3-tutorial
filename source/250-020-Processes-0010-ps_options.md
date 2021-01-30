### "/bin/ps" options

My students sometimes ask what options CFEngine uses when it runs
`/bin/ps`, since `/bin/ps` can be different based on UNIX/Linux system
flavor.

CFEngine encapsulates the knowledge of how to administer various types
of UNIX-like systems, including the various `/bin/ps` options (of even if
`ps` is in another path); see
<https://github.com/cfengine/core/blob/0e5e8c52ba2779db3b8b9573c2b6abb807528df7/libpromises/systype.c#L95-L124>

You can also run CFEngine agent in **verbose mode** and it'll tell you
_how_ it's observing the process table.
