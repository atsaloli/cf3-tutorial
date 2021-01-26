Render a JSON-backed Mustache template

1. Make a JSON file:

```bash
echo '{ "food" : "pizza" }' > food.json
```

2. Make a Mustache template:

```bash
echo "Waiter, I'd like to order {{food}}" > order.mustache
```

3. Write CFEngine policy that will render the Mustache 
   template using the data in the JSON file.

Hint: see the `readjson()` function in the reference manual.


