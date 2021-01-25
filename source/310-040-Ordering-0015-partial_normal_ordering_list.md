### Ordering

There is an order to promise evaluation.

Promises are evaluated in order by promise type.

For example, for the promise types we've covered,
the order is:

- vars
- files
- methods
- processes
- commands
- reports

This order is very intentional and is not configurable.

For example, Variables are evaluated first as they may be used in other
promises.

Files are handled before Processes as one may want to configure a service
and then launch the daemon.

Processes come before Commands as one may want to run a command to start
or stop a service depending on whether the process is running.

Reports come last so that the reports are not immediately made out of
date (in other words, reports are last so that CFEngine doesn't report
something and then changes it).

This is called **Normal Ordering**.

Reference: [Normal Ordering](https://docs.cfengine.com/latest/guide-language-concepts-normal-ordering.html)
