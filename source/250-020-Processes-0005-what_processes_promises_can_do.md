### What processes promises can do

* You can promise that a pattern be **present** to ensure a process is
running, such as `snmpd` for monitoring or `adclient` for using Active
Directory;

* to be **absent** (you can run a command to stop a process or you can
signal it, e.g., `TERM` or `KILL`);

* or you can **make decisions** based on your findings (such as restarting
a process when memory size grows past a limit).

Recap: You can use `processes:` promises to manage system processes.
