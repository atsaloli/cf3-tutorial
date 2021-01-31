#### Policy Distribution Flow

The CFEngine agent runs twice in each cycle:
- Checks for policy updates (and copies them from /var/cfengine/masterfiles/ on the hub to the local /var/cfengine/inputs/)
- Runs the policy in /var/cfengine/inputs/

This "caching" of policy makes CFEngine resilient to network outages. CFEngine uses the network opportunistically.

The default schedule is the agent runs every 5 minutes.

So you can update hundreds of thousands of servers within minutes. Very powerful!
