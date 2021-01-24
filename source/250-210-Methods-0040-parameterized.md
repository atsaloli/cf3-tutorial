You can parameterize a methods promise:

```cfengine3
  methods:                                                                                                                             
      "Remove Users"                                                                                                                   
        usebundle => remove_user("bob");           
```
