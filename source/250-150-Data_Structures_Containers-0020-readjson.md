You can read in a JSON file with the CFEngine `readjson()` function:

```cfengine3
    vars:

     "loaded_data"
       data => readjson("/tmp/myfile.json", 40000);
```

Reference: [readjson](https://docs.cfengine.com/latest/reference-functions-readjson.html)


