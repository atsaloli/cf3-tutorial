## Methods

Methods are compound promises that refer to whole bundles of promises.

You can use them to group together related promises.

Example:

```cfengine3
bundle agent main
{
  methods:
      "base_os_config";  # configure the OS
      "application_config"; # and the application
}

bundle agent base_os_config { ... }

bundle agent application_config { ... }
```

We will learn more about `methods:` promises later.
