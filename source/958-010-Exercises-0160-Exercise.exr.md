Use a CFEngine template

Create a template by running the following shell command:

```bash
echo 'Hello, $(mybundle.myname).  The time is $(sys.date).' > /tmp/file.dat
```


Note: a fully qualified variable consists of the bundle name wherein the variable is defined plus the variable name.

Example:

```cfengine3
bundle agent mybundle { vars: "myvar" string => "myvalue"; }
```

The fully qualified variable name is `$(mybundle.myvar)`.

Now write a policy to populate contents of /tmp/file.txt using this template file, /tmp/file.dat.

Make sure your bundle defines the variable embedded in the template, and that your bundle name matches the bundle name embedded in the template.

Your policy should use an edit_lines bundle containing an insert_lines promise with the following attributes:

```cfengine3
insert_type => "file",
expand_scalars => "true";
```
