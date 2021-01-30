#### Syntax Description

You can also use `cf-promises` to dump a JSON document
describing the available syntax elements.

```bash
sudo cf-promises --syntax-description json --file /dev/null
```

Note: The syntax dump feature was "bolted on" to `cf-promises`,
so that's why `cf-promises` _requires_ the `--file` switch.
