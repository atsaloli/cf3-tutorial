Copy /usr/local/sbin/ to /tmp/mirror/

1. Use CFEngine to make '/tmp/mirror/' contain a copy of '/usr/local/sbin/'
(Hint: use a files promise with a copy_from attribute.)

2. Now create a new file in '/usr/local/sbin/' and confirm CFEngine will copy it over.

3. Work out how to mirror file removals. (When a file is removed in '/usr/local/sbin/', it should disappear in '/tmp/mirror/'.)  (Hint: find the appropriate promise attribute in our Agent Promise Attributes summary or in the CFEngine Reference Manual.)

----
Remote copy exercise

Purpose: practice writing a "remote copy" promise.

1. Manually create a master for the MOTD: /var/cfengine/masterfiles/motd.txt on your hub

2. Add a promise to your masterfiles framework to make /etc/motd a remote copy from the master on the hub.

Note: The special variable $(sys.policy_hub) contains the address of the Hub.  CFEngine records the address of the hub in /var/cfengine/policy_server.dat after a successful bootstrap 



Exercise

/tmp/cfe/ should be a copy of /var/cfengine/masterfiles/ from $(sys.policy_hub)

(Hint: you can use "body copy_from remote_cp" or "body copy_from secure_cp")

vars:
  "myvar"
    data => readjson ("/tmp/stuff.json", "100k"),
    if => fileexists ("/tmp/stuff.json");





























