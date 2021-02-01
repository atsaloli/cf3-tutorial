The braces are mandatory. Braces help the parser know for sure when a
variable name ends so it doesn't have to guess if the variable name is
embedded in text:

```cfengine3
reports:
  "The product number is: $(machine_type)$(model)";
```

CFEngine doesn't like to guess about infrastructure.

Infrastructure is too important; we shouldn't be guessing about it.
