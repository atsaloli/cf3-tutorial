Create executable shell script

Write a CFEngine policy to ensure '/usr/local/bin/hello.sh' exists,
has permissions 0755, owner root, group root, and contents:

```bash
#!/bin/sh
/bin/echo hello world
```
