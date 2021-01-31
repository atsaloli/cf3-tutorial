However, you _do_ need the `usebundle` if you want to parameterize the methods call:

```cfengine3
  methods:                                                                                                                             
      "Remove Users"                                                                                                                   
        usebundle => remove_user("bob");           
```
