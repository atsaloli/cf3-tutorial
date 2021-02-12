
# Final Course Exercise

Edit /var/cfengine/masterfiles/services/main.cf on your hub

Add a bundle (you can put it in the same file)

with a `files:` promise to manage `/etc/motd` as follows:

1. On the hub only, make /etc/motd say "CFEngine Policy Server"
2. On hub and host, make it say: "Owner: Your Name"
3. Ensure file is world-readable


Then, verify that the hub and host have the intended configuration.


