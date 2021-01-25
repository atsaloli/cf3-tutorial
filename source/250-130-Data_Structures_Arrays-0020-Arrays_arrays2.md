Example:

| Food    | Price |
|---------|-------|
| Apple   | 59c   |
| Banana  | 30c   |
| Oranges | 35c   |

Variable assignment:

```cfengine3
vars:
    "food_prices[Apple]"
      string =>  "59c";
```
  
Now we can use this variable:
```cfengine3
reports:
    "An apple costs $(food_prices[Apple])";
```

