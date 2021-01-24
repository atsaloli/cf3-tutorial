### process_stop

Description: A command used to stop a running process

As an alternative to sending a termination or kill signal to a process, one may call a 'stop script' to perform a graceful shutdown.

Type: string

Allowed input range: "?(/.*)

Example:


```cfengine3
  processes:

      "cupsd"

        process_stop => "/sbin/service cups stop";
```

Reference: <https://docs.cfengine.com/docs/3.17/reference-promise-types-processes.html#process_stop>
