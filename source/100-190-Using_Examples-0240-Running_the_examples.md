### Running the examples

All of the examples are shipped as standalone CFEngine 3 files which
you can run on the command-line by specifying the path to the input
file with the *-f* switch:

```bash
cf-agent -f ./create_file.cf
```

If you don't specify the path to your file, CFEngine will look for
it in the default policy directory which is /var/cfengine/inputs/
if you are running `cf-agent` as "root", and $HOME/.cfagent/inputs/
if you are running it as a regular user.

We assume you will be running all examples and
doing all exercises as "root".

Note: CFEngine normally runs as "root" but it can be run as non-root, and
some large organizations even run it as both root and non-root on
the same system (running off different policies from different divisions 
of the organization, e.g. base config versus applicaiton-specific
config).

CFEngine agent requires a list of bundles to evaluate (a bundle is a
group of promises). If you are using CFEngine version older than 3.7,
you will need to specify the list of bundles to run using the *-b* switch:

```bash
cf-agent -f ./create_file.cf -b main
```

To find out your CFEngine version, use the *-V* switch which is also
available in long form as *--version**:

```bash
# cf-agent -V
CFEngine Core 3.7.1
CFEngine Enterprise 3.7.1
#
```

Here we see the free open-source core ("CFEngine Core") is version 3.7.1 and so is the commercial extension ("CFEngine Enterprise"). 
