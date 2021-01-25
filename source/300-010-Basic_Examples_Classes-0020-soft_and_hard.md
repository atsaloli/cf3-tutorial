### Hard and soft classes defined

There are two types of classes in CFEngine:

**Hard classes**
: Hard classes are inherent, or built-in. The first thing that `cf-agent`
does when it starts is to classify its environment (e.g.  OS type = linux,
OS version = redhat 6.5, date = Sun Nov  8 17:09:57 PST 2015, CFEngine
version = 3.7, hostname = alpha.example.com, domain = example.com, CPU
architecture = 64 bit, etc.)  This data can be used to control promise
execution (e.g. kick off backups at 2 AM on Sunday on Linux hosts)

**Soft classes**
: Soft classes are user-defined through promises, and provide additional
flexibility in classifying hosts (e.g. by application, or primary vs
DR) and controlling promise execution (e.g. only evaluate promise2 if
promise1 was repaired).

Note on syntax: CFEngine identifiers (class names, variable names, bundle
names, etc.) may only contain alphanumeric and underscore characters (a-zA-Z0-9_).

Let's see some examples of hard classes.

### Hard classes

