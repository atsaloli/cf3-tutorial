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
