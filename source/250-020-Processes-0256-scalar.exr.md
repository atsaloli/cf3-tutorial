Point out the scalar values in the following CFEngine policy.

```cfengine3
bundle agent main
{
  processes:

      "cupsd"

        comment => "Shutdown print service",
        process_stop => "/sbin/service cups stop";

}
```
