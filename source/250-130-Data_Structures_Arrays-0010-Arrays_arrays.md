Arrays are associative (hashes). 

They may contain scalars or lists as their elements.

Array variables are written with '[' and ']' brackets:

```cfengine3
$(array_name[key_name])
```

or

```cfengine3
$(bundle_name.array_name[key_name])
```

Example:

| Food    | Price |
|---------|-------|
| Apple   | 59c   |
| Banana  | 30c   |
| Oranges | 35c   |

Variable assignment:

```cfengine3
vars:   "food_prices[Apple]"    string =>  "59c";
```
  
Now we can use this variable:
```cfengine3
$(food_prices[Apple])
```
