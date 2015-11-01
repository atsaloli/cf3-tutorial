### Identifying scalar variables

A scalar variable is represented as

```cfengine3
$(identifier)
```

or

```cfengine3
${identifier}
```

Round braces are Make-style; curly braces are UNIX shell style.

Example:
```cfengine3
reports:
  "Hello, $(name)";
```

Braces help the parser know for sure when a variable name ends so it doesn't have to guess if the variable name is embedded in text: 

```cfengine3
reports:
  "The product number is: $(machine_type)$(model)";
```
