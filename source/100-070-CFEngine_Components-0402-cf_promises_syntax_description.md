#### Syntax Description

You can also use `cf-promises` to dump a JSON document
describing the available syntax elements.

```bash
sudo cf-promises --syntax-description json --file /dev/null
```

Note: The syntax dump feature was "bolted on" to `cf-promises`,
so `cf-promises` requires the `--file` switch.

```bash
alias cf-syntax='sudo cf-promises --syntax-description json --file /dev/null | jq .'
```
