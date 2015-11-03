
### Inter-Node Communication

**cf-serverd**
: File server, used to distribute files; listens for network requests for additional runs of the local agent.  

**cf-key**
: Key generation tool, used on every host to create public/private key pairs for secure communication.

**cf-runagent**
: Remote run agent, is used to execute cf-agent on a remote machine.  cf-runagent does not keep any promises, but instead is used to ask another machine to do so.

**cf-hub**
: CFEngine Enterprise only, used to collect reports from hosts (connects to remote cf-serverd).
