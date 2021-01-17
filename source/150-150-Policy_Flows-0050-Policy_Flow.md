### Policy Flow Diagram

#### Definitions

**Policy server**
: A server that shares CFEngine files (policy, data, templates, scripts, binaries) with the rest of the infrastructure using cf-serverd. Also called the hub.

**Policy distribution point**
: The default policy distribution point is /var/cfengine/masterfiles on the policy server. Policy comes from here; in other words, the managed hosts get their policy from /var/cfengine/masterfiles on the policy server (also called the hub).

**Inputs directory**
: The inputs directory is where CFEngine looks for its policy files (defaults to /var/cfengine/inputs).

#### Policy Distribution Flow

The CFEngine agent runs twice in each cycle:
- Checks for policy updates (and copies them from /var/cfengine/masterfiles/ on the hub to the local /var/cfengine/inputs/)
- Runs the policy in /var/cfengine/inputs/

This "caching" of policy makes CFEngine resilient to network outages. CFEngine uses the network opportunistically.

The default schedule is the agent runs every 5 minutes.

So you can update hundreds of thousands of servers within minutes. Very powerful!
