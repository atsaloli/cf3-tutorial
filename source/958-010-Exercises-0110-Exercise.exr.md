## Configure sshd

How does the system look like in the correct configuration:

1. Make sure '/etc/ssh/sshd\_config' contains the line "PermitRootLogin no"

2. Make sure sshd is running using this configuration

How to code it in CFEngine:

1. a files promise to edit sshd\_config

2. a commands promise to restart sshd to reload the new config

Exercise:  use "body classes if\_repaired" to link 1 and 2 above to make sure 2 happens.

