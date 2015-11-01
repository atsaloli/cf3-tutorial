### Make a mustache template that accesses variables from CFEngine datastate

Example, put the value of the hostname into /etc/motd

```cfengine3
$(sys.fqhost)
```


Example mustache template text:

```text
   The time is: {{vars.sys.date}}
```

### Make a mustache template that accesses classes from CFEngine datastate


```text
{{#classes.linux}}
we love linux {{vars.sys.flavour}}
{{/classes.linux}}
```
