### signals

Description: A list of menu options representing signals to be sent to a process.

Signals are presented as an ordered list to the process. On Windows, only the kill signal is supported, which terminates the process.

Type: (option list)

Allowed input range:

- hup
- int
- trap
- kill
- pipe
- cont
- abrt
- stop
- quit
- term
- child
- usr1
- usr2
- bus
- segv

Reference: https://docs.cfengine.com/latest/reference-promise-types-processes.html#process_stop
