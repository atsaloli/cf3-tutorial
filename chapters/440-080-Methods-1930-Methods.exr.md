Sysadmin Problem:

'/etc/profile' should set the ORGANIZATION environment variable when users log in:

```bash
export ORGANIZATION=MyOrg
```

Policy Writing Exercise:

Write a bundle "etc_profile_contains" that would take an argument and ensure '/etc/profile' contains the text string specified in the argument.

Demonstrate its use by calling it from another bundle:

```cfengine3
    bundle agent example {
       methods:
         "any"
             usebundle => etc_profile_contains("export ORGANIZATION=MyOrg");
    }
```
