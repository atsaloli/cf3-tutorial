Data containers - readjson

Turn your array from the previous exercises into
a JSON data file, e.g., `phones.json`:

```
{
  "iPhone"  : "$500",
  "Samsung" : "$450"
}
```

Read it into a data container with `readjson()`, e.g.:


```cf3
  vars:

      "phones"
        data => readjson("$(this.promise_dirname)/phones.json", "100k");

```

Report the contents of the data container

Hints:

- get the keys using getindices()
- iterate over the keys to report the values
