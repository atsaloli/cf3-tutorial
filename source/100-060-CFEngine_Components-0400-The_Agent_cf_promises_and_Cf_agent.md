CFEngine 3 consists of a number of components.

###  Agent (and the Syntax Checker it relies on)


**cf-agent**
: The CFEngine component that audits and makes any needed repairs to your system system. Actually does the work, as far as configuration management is concerned.

```bash
   cf-agent -f ./your_policy.cf
```

**cf-promises**
: Syntax checker.

```bash
    cf-promises -f ./your_policy.cf
```

Every CFEngine component runs cf-promises on policy files before reading them in.
