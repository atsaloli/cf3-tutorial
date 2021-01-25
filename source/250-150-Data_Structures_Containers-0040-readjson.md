You can read in a JSON file with the CFEngine `readjson()` function:

```cfengine3
    vars:

     "loaded_data"
       data => readjson("/tmp/myfile.json", 40K);
```

The first argument is the filename.

The second argument is optional, maxbytes to read in.

Reference:
- [readjson](https://docs.cfengine.com/latest/reference-functions-readjson.html)
- [readyaml](https://docs.cfengine.com/latest/reference-functions-readyaml.html)




