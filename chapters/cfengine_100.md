
<!---
Filename: 100-000-Part-Title-0000-Orientation.md
-->

# Orientation



<!---
Filename: 100-010-About\_Collection-0000-Chapter-Title.md
-->

## About the CFEngine Examples Collection



<!---
Filename: 100-010-About\_Collection-0010-About\_The\_Author.md
-->

### About the Author

I've been working in IT Operations since the mid-nineties, mostly as a
UNIX/Linux System Administrator of one kind or another, though now I'm
called DevOps Engineer.

I've helped a number of organizations, large and small, adopt CFEngine,
and have been recognized as a CFEngine Community Champion by Northern.tech,
the company behind CFEngine.

I was trained on CFEngine by Mark Burgess, the author of CFEngine.



<!---
Filename: 100-010-About\_Collection-0030-About\_This\_Course.md
-->

### About the Course

*Introduction to Automating System Administration with CFEngine 3 (5 days)*

**Requirements**: No knowledge of CFEngine or configuration management is
required, only basic knowledge of system administration.

**Hardware requirements**: Bring a laptop with wi-fi capability.

At the end of this course you will be able to:

- Automate system administration (server setup, maintenance and compliance reporting),
- Create a trustworthy and reliable computing services infrastructure.



<!---
Filename: 100-010-About\_Collection-0040-discussion\_question.md
-->

### Discussion Question

What problems would you like to solve with automation?



<!---
Filename: 100-010-About\_Collection-0130-About\_this\_collection.md
-->

### Training Examples

I've put together this collection of over 200 standalone working examples
of CFEngine 3 code to help get infrastructure engineers up to speed with
CFEngine 3.

These examples _supplement_ the examples in the official documentation.

All examples are standalone and runnable.

If you have trouble with any of them, please let me know!



<!---
Filename: 100-010-About\_Collection-0140-github\_repo.md
-->

### GitHub Repo

This collection grew to support my professional course "Introduction
to Automating System Administration using CFEngine 3".

I've put these materials online to make it easier for infrastructure
engineers to learn CFEngine 3, to build a stable civilization.

[https://github.com/atsaloli/cf3-tutorial](https://github.com/atsaloli/cf3-tutorial)



<!---
Filename: 100-010-About\_Collection-0145-using\_the\_examples.md
-->

### Using the Examples

The materials are arranged in logical sequence for study.

You may also use them to find examples of a specific
feature or promise attribute.




<!---
Filename: 100-010-About\_Collection-0148-run\_the\_examples.md
-->

### Run the Examples

Try out and run the examples. Modify them. Do the provided
exercises to practice using this new tool and to get to know
it.

Work your way through the materials until you understand them
and have done the provided exercises. There are additional
exercises at the end of the tutorial, or just start writing
your own code!




<!---
Filename: 100-010-About\_Collection-0149-look\_up\_unfamiliar\_terms.md
-->

### Look Up Unfamiliar Terms

Look up unfamiliar terms in the [CFEngine Reference
Manual](http://docs.cfengine.com), or in a good [English
dictionary](http://www.onelook.com).



<!---
Filename: 100-010-About\_Collection-0150-Feedback\_wanted.md
-->

### Feedback Wanted

If these examples are helpful to you, if you have any questions,
or if you would like to contribute an example, please email me
at aleksey (at) verticalsysadmin.com. I would love to hear from you!




<!---
Filename: 100-030-Why\_Automation-0000-Chapter-Title.md
-->

## Why Automation?

> Every time someone logs onto a system by hand, they jeopardize
> everyone's understanding of the system.
>
> --- Mark Burgess, author of CFEngine


Benefits of automation:

- decreases labor costs
- increases quality of IT services
- frees humans from drudgery, to focus on more challenging work

See "Why Automation?" in the original [CFEngine 3 Tutorial](https://auth.cfengine.com/archive/manuals/cf3-tutorial#Why-automation_003f)



<!---
Filename: 100-050-What\_is\_CFEngine-0000-Chapter-Title.md
-->

## What is CFEngine?

At this point a brief introductory lecture is given on what is CFEngine
and desired state management, based on the presentation by Mark Burgess
at USENIX Configuration Management summit 2010.


Link:

<https://github.com/atsaloli/cf3-tutorial/raw/master/mark-burgess-config10-slideshow/burgess-config10-pg01-06.pdf>

Reference:

Slides 1-6 from <https://www.usenix.org/legacy/event/config10/burgess.pdf>



<!---
Filename: 100-050-What\_is\_CFEngine-0020-nickanderson-cfprimer.md
-->

### Declarative/Imperative and Promise Theory

At this point we switch to Nick Anderson's "CFEngine Zero to Hero
Primer" slidedeck and go over the following sections:

* Declarative/Imperative
* Promise Theory

<https://htmlpreview.github.io/?https://github.com/nickanderson/CFEngine-zero-to-hero-primer/blob/master/CFEngine-zero-to-hero.html>



<!---
Filename: 100-050-What\_is\_CFEngine-0030-lifecycle.md
-->

### System Lifecycle and Automation

The following system lifecycle diagram is from Remy Evard, "An Analysis
of UNIX System Configuration", USENIX Proceedings: Eleventh Systems
Administration Conference (LISA 1997), October 26-31, 1997

<https://raw.githubusercontent.com/atsaloli/cf3-tutorial/master/images/figures/lifecycle.png>



<!---
Filename: 100-050-What\_is\_CFEngine-0032-lifecycle\_of\_a\_machine.BOOKONLY.md
-->

![Alt text](images/figures/lifecycle.pdf)



<!---
Filename: 100-055-Why\_CFEngine-0000-Chapter-Title.md
-->

## Why CFEngine?

- Mature (since 1993, now in its third generation)
- Small footprint (can run everywhere and run often)
- Fast!!
- Scalable (real-world deployments of hundreds of thousands of hosts
  or more)
- Secure (check the US National Vulnerabilities Database, much less
  vulnerabilities due to a more secure design)
- Portable (many systems and platforms supported)
- The only configuration management tool based on science (author is a
  theoretical physicist turned Computer Science researcher)

To learn more, see [20 Years of
CFEngine](http://markburgess.org/blog_principles.html), by Mark Burgess.



<!---
Filename: 100-055-Why\_CFEngine-0005-scalable.md
-->

### Scalability

It takes the same amount of time to deploy and validate changes
with CFEngine regardless of fleet size.

<https://github.com/atsaloli/cf3-tutorial/raw/master/images/figures/AnsibleCFEngine_whitepaper_2.png>

Graph from "Ansible and CFEngine Scalability" by Vratislav Podzimek, Northern.tech
whitepaper, 12 January 2021.




<!---
Filename: 100-055-Why\_CFEngine-0010-NVD\_search.md
-->

### NVD Search Results Comparison

The following is the CVE count as of 30 January 2021.

| Product | NVD CVE Search Results |
|---------|------------------------|
| CFEngine | 2 for CFEngine version 3.x (released 2008)|
| Puppet | 177
| Chef | 42
| Ansible | 92
| SaltStack | 34

NVD links:
- [CFEngine](https://nvd.nist.gov/vuln/search/results?form_type=Basic&results_type=overview&query=cfengine&search_type=all)
- [Puppet](https://nvd.nist.gov/vuln/search/results?form_type=Basic&results_type=overview&query=puppet&search_type=all)
- [Chef](https://nvd.nist.gov/vuln/search/results?form_type=Basic&results_type=overview&query=chef&search_type=all)
- [Ansible](https://nvd.nist.gov/vuln/search/results?form_type=Basic&results_type=overview&query=ansible&search_type=all)
- [SaltStack](https://nvd.nist.gov/vuln/search/results?form_type=Basic&results_type=overview&query=saltstack&search_type=all)



<!---
Filename: 100-063-CFEngine\_Packages-0000-Chapter-Title.md
-->

## CFEngine Packages




<!---
Filename: 100-063-CFEngine\_Packages-0000-community\_and\_enterprise.md
-->

### CFEngine Packages

CFEngine is available in two flavors.

#### Open Source Core

**cfengine-community**
: Open-source product, also known as CFEngine Core.

#### Enterprise

**cfengine-nova**
: Core plus Enterprise extensions (reporting, native Windows build, etc.).

**cfengine-nova-hub**
: cfengine-nova plus the the Mission Portal (Web UI on an Apache/PHP/PostgreSQL stack; and inventory and compliance report collector).

A note on naming: The name for the first generation of the CFEngine Enterprise product was "Nova", which is still reflected in the name of the Enterprise packages. The original plan was to have progressively larger star names like "Constellation" and "Galaxy", that would each have progressively more features.



<!---
Filename: 100-063-CFEngine\_Packages-0020-examination\_of\_rpm.md
-->

### Inspect the CFEngine Core Package

#### Download Core package

```bash
wget https://cfengine-package-repos.s3.amazonaws.com/community_binaries/\
Community-3.12.6/agent_rhel8_x86_64/cfengine-community-3.12.6-1.el8.x86_64.rpm
```
or get it from [CFEngine](https://cfengine.com/product/community/)

#### Examine package

Let's examine the package so you can see what gets installed on your system when you install Core.

```bash
rpm -q --filesbypkg cfengine-community-*.rpm | less
```



<!---
Filename: 100-063-Enterprise-0050-how\_enterprise\_works.md
-->

### CFEngine Enterprise - Reporting

CFEngine Enterprise unlocks unparalleled insight into infrastructure:

- promise compliance (including outliers)
- changes (repairs)
- inventory and compliance reports (at any level of abstraction -- from
  enterprise-wide down to an individual host)

CFEngine Enterprise components:

- Hub (report collection and admin UI)
- Super-Hub (reporting UI, for large enterprises)

How reporting works:

1. Hubs pull policy from version control (e.g. Git)
2. Hosts pull policy from hubs and execute it and create inventory and
   compliance reports
3. Hubs download inventory/compliance reports from hosts and aggregate them




<!---
Filename: 100-070-CFEngine\_Components-0000-Chapter-Title.md
-->

## CFEngine Components

CFEngine 3 consists of a number of components.



<!---
Filename: 100-070-CFEngine\_Components-0400-cf\_promises\_syntax\_check.md
-->

### Syntax Checker

**cf-promises**
: Syntax checker.

```bash
cf-promises -f ./your_policy.cf
```
Every CFEngine component runs `cf-promises` on policy files before reading them in.



<!---
Filename: 100-070-CFEngine\_Components-0420-cf\_promises\_syntax\_description.md
-->

#### Syntax Description

You can also use `cf-promises` to dump a JSON document
describing the available syntax elements.

```bash
sudo cf-promises --syntax-description json --file /dev/null
```

Note: The syntax dump feature was "bolted on" to `cf-promises`,
so that's why `cf-promises` _requires_ the `--file` switch.



<!---
Filename: 100-070-CFEngine\_Components-0430-cf\_promises\_syntax\_alias.md
-->

#### cf-syntax alias

```bash
alias cf-syntax='sudo cf-promises --syntax-description json --file /dev/null'
```



<!---
Filename: 100-070-CFEngine\_Components-0432-jq\_intro.md
-->

#### Parsing JSON with jq

You can use `jq` to parse/query JSON data such as that returned by
`cf-promises`.



<!---
Filename: 100-070-CFEngine\_Components-0434-jq\_installing\_jq.md
-->

##### Installing jq

On RHEL 7, use the latest Fedora EPEL repo to install `jq`.

References:
* https://stedolan.github.io/jq/



<!---
Filename: 100-070-CFEngine\_Components-0436-jq\_using\_jq.md
-->

##### Using jq to parse CFEngine syntax document

Example of using jq -- list all available promise types:

```console
$ cf-syntax | jq '.promiseTypes | keys' | head
[
  "access",
  "build_xpath",
  "classes",
  "commands",
  "databases",
  "defaults",
  "delete_attribute",
  "delete_lines",
  "delete_text",
...
```



<!---
Filename: 100-070-CFEngine\_Components-0440-agent.md
-->


### Agent

**cf-agent**
: The CFEngine component that audits and makes any needed repairs to your system. Actually does the work, as far as configuration management is concerned. This is the workhorse.

```bash
cf-agent -f ./your_policy.cf
```



<!---
Filename: 100-070-CFEngine\_Components-0450-The\_Executor\_cf\_execd.md
-->


### Executor

**cf-execd**
: Runs cf-agent on a regular basis, and handles its output.



<!---
Filename: 100-070-CFEngine\_Components-0460-Networking\_cfserverd\_cfkey\_cfrunagent.md
-->


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



<!---
Filename: 100-070-CFEngine\_Components-0470-cfmonitord\_cfknow\_cfreport\_cfhub.md
-->


### Monitoring

**cf-monitord**
: Passive monitoring agent, collects information about the status of the system (which can be reported or used to influence when promises are enforced).



<!---
Filename: 100-070-CFEngine\_Components-0480-extras.md
-->

### Utilities

**cf-check**
: Utility for diagnosis and repair of local CFEngine databases. Intended to detect and repair a corrupt database.

**cf-net**
: Testing/debugging tool. cf-net connects to cf-serverd on a specified host and can issue arbitrary CFEngine protocol commands.

**cf-key**
: Generates the keypair used to secure network communications.

**cf-upgrade**
: Helper tool used by CFEngine to upgrade itself (version update).



<!---
Filename: 100-070-CFEngine\_Components-0490-small\_binaries.md
-->

### A Note on Size

The CFEngine agent is a small C binary. The other components are even smaller C binaries.

```console
$ ls -lh /var/cfengine/bin/cf-* |
> awk '{print $NF, $5}' | sort | column -t
/var/cfengine/bin/cf-agent     1.8M
/var/cfengine/bin/cf-check     710K
/var/cfengine/bin/cf-execd     160K
/var/cfengine/bin/cf-key       84K
/var/cfengine/bin/cf-monitord  448K
/var/cfengine/bin/cf-net       73K
/var/cfengine/bin/cf-promises  53K
/var/cfengine/bin/cf-runagent  69K
/var/cfengine/bin/cf-serverd   472K
/var/cfengine/bin/cf-upgrade   68K
$
```




<!---
Filename: 100-070-CFEngine\_Components-0500-lightweight\_high\_freq\_runs.md
-->

Because CFEngine is lightweight, it's fast. It can be run frequently to monitor and maintain
infrastructure health.

CFEngine 1 was intended to be run once a day.

CFEngine 2 was intended to be run once an hour.

CFEngine 3 default run frequency is every 5 minutes.

At 5 minutes, systems can self-heal faster than if they were repaired by human operators.




<!---
Filename: 100-070-CFEngine\_Components-0532-add-ons.md
-->

### Add-ons

A number of add-on tools are available, thanks to community contributions. For example:

**cf-diag**
: Diagnostic tool (checks the health of a CFEngine host).

**masterfiles-stage**
: Policy deployment tool - designed to run on the Policy Server and safely deploy policy from upstream locations to a directory on the Policy Server for distribution to clients.

**cf-profile**
: Measures how long your code takes to run so you can keep CFEngine agent runs blazing fast.

**cf-remote**
: Tooling to deploy CFEngine on remote hosts.

And more! Check out [https://github.com/cfengine/core/blob/master/contrib/](https://github.com/cfengine/core/blob/master/contrib/)



<!---
Filename: 100-070-CFEngine\_Components-0550-daemons.md
-->

CFEngine daemons

Here is what you typically see between `cf-agent` runs:

```console
$ ps -ef |grep [c]f-
root     807   1  0 Jan26 ?    00:00:34 /var/cfengine/bin/cf-monitord --no-fork
root     833   1  0 Jan26 ?    00:00:13 /var/cfengine/bin/cf-execd --no-fork
root    1367   1  0 Jan26 ?    00:00:08 /var/cfengine/bin/cf-serverd --no-fork
$
```



<!---
Filename: 100-070-CFEngine\_Components-0600-review\_components.md
-->

### Review: CFEngine Binaries

What do these binaries do?

- cf-agent
- cf-promises
- cf-execd
- cf-serverd


