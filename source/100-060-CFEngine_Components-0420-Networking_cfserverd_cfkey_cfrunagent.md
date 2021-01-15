
### Network Communication

**cf-serverd**
: Has three functions: file server, for distributing files; it also listens for network requests for additional runs of the local agent (triggered by cf-runagent); in CFEngine Enterprise, it also serves inventory and compliance reports (when the hub asks for them).

**cf-runagent**
: Triggers cf-agent on a remote machine (connects to remote cf-serverd).

**cf-hub**
: CFEngine Enterprise only, collects reports from hosts (connects to remote cf-serverd).
