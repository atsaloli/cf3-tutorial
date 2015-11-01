### Scope of variables

Note: a fully qualified variable consists of the bundle name wherein the variable is defined plus the variable name. 

```cfengine3
bundle agent mybundle {
  vars:
      "myvar"
        string => "myvalue";
}
```

Unqualified: $(myvar) 

Qualified: $(mybundle.myvar) 

