Kill a process

Start print services manually (e.g., `yum install -y cups; service cups
start`) and then write and run a promise to signal the `cupsd` process
TERM and KILL

Don't copy and paste, type it yourself.

And try to do it from memory.  (Okay to look back if you need to.)

Note: signal name values in CFEngine are in lower-case and CFEngine
is case-sensitive.

Reference:
<https://docs.cfengine.com/docs/3.12/reference-promise-types-processes.html#signals>

What happens if you give CFEngine a right-hand side value (signal name)
that it doesn't recognize? What error message do you get? What does it
mean?



