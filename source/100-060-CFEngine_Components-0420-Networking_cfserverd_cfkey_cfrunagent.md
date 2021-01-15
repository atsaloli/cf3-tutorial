
### Network Communication

**cf-serverd**
: Has three functions:
- file server, for distributing files
- reports server (Enterprise only)
- listens for network requests for additional runs of the local agent

**cf-runagent**
: Triggers cf-agent on a remote machine (connects to remote cf-serverd).

**cf-hub**
: CFEngine Enterprise only, collects reports from hosts (connects to remote cf-serverd).
