Copy /usr/local/sbin/ to /tmp/mirror/

1. Use CFEngine to make '/tmp/mirror/' contain a copy of '/usr/local/sbin/'
(Hint: use a files promise with a copy_from attribute.)

2. Now create a new file in '/usr/local/sbin/' and confirm CFEngine will copy it over.

3. Work out how to mirror file removals. (When a file is removed in '/usr/local/sbin/', it should disappear in '/tmp/mirror/'.)  (Hint: find the appropriate promise attribute in our Agent Promise Attributes summary or in the CFEngine Reference Manual.)

----
Remote copy exercise

1. create /var/cfengine/masterfiles/static/motd on hub

2. make your /etc/motd a copy from the hub's /var/cfengine/masterfiles/static/motd

