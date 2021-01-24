Now let's run the "update" policy to update our /var/cfengine/inputs/
directory from /var/cfengine/masterfiles/ :

```console
# cf-agent -IC -f update.cf
    info: Updated '/var/cfengine/inputs/services/main.cf' from source
'/var/cfengine/masterfiles/services/main.cf' on 'localhost'
# 
```

