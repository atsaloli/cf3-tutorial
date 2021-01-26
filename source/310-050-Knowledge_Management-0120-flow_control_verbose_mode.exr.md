Run 310-050-Knowledge_Management-0060-depends_on.cf in verbose mode.

How many passes through the bundle does it take to report both promises?

On which pass is the "Fueling" report made?

On which pass is the "Launch!!" report made? Why?

```cfengine3
bundle agent main
{
  reports:

      "Launch!!"
        depends_on => { "fuel" },
        handle => "launch";

      "Fueling"
        handle => "fuel";
}
```
