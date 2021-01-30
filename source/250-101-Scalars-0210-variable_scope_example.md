#### Example 

Let's say the variable `first_name` is defined in the bundle `names`:

```cfengine3
bundle agent names
{
  vars:
      "first_name"
        string => "John";
}
```

Unqualified reference:

```cfengine3
reports: "Hello, $(first_name)";
```

Qualified reference:

```cfengine3
reports: "Hello, $(names.first_name)";
```
