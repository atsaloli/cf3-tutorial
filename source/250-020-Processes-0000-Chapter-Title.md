## Processes

Processes promises refer to items in the system process table.

CFEngine uses the output from the `ps` command to inspect running
processes.

In `processes:` promises, the promiser objects are patterns that are
_unanchored_, meaning that they match parts of command lines in the
system process table.

CEFngine uses libpcre to handle pattern-matching (regular expressions).

Reference:
- [PCRE - Perl Compatible Regular Expressions](https://www.pcre.org/)

You can promise that a pattern be **present** to ensure a process is
running, such as `snmpd` for monitoring or `adclient` for using Active
Directory; to be **absent** (you can run a command to stop a process
or you can signal it, e.g., `TERM` or `KILL`); or you can **make
decisions** based on your findings (such as restarting a process when
memory size grows past a limit).

Recap: You can use `processes:` promises to manage system processes.
