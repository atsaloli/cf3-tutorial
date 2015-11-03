
<!---
Filename: 100-000-Part-Title-0000-Orientation.md
-->

# Orientation and Setup



<!---
Filename: 100-010-About\_Collection-0000-Chapter-Title.md
-->

## About the Collection



<!---
Filename: 100-010-About\_Collection-0130-About\_this\_collection.md
-->

### Training examples

Vertical Sysadmin, an authorized CFEngine training partner,
has put together a collection of over 200 standalone working
examples of using CFEngine 3 to help get infrastructure
engineers up to speed with CFEngine 3.

These examples supplement the examples in the official
documentation.

All our examples are concrete and runnable.



<!---
Filename: 100-010-About\_Collection-0140-Using\_this\_collection.md
-->

### Using this collection

Our course "Automating System Administration using CFEngine 3" is
based on demonstration of "CFEngine Essentials" examples, along with
with discussion, lab exercises, and a policy-writing workshop.

To support the growing CFEngine 3 community, we are making available
our course materials online.

The materials are arranged in sequence, so your initial study
should be in sequence.

You can also use these materials as reference (feel free to pull
out examples and use them to seed your policy set).




<!---
Filename: 100-010-About\_Collection-0145-collection\_scripts.md
-->

### Using the examples

The materials are arranged in sequence, so we recommend you
study them in sequence; however you can also use them as
reference (to find specific examples of a feature or
promise attribute).

You are welcome to seed your policy set with any of these
examples.  We hope they will be of use to you!



<!---
Filename: 100-010-About\_Collection-0150-Feedback\_wanted.md
-->

### Feedback Wanted

I would love to hear if you have wins with this collection,
or if you need help with anything.  Write me at aleksey (at) verticalsysadmin.com

### Training and Professional Services
I'm available for on-site training and implemention consulting.



<!---
Filename: 100-010-About\_Collection-148-run\_the\_examples.md
-->

### Run the Examples

Try out and run the examples. Modify them.  Do the provided
exercises to practice using this new tool and to get to know
it.

Work your way through the materials until you understand them
and have done the provided exercises.  There are additional
exercises at the end of the tutorial, or just start writing
your own code!

### Look up any unfamiliar terms
Misunderstood or not understood terms can block understanding.
Look up unfamiliar terms in the [CFEngine Refernce Manual](http://docs.cfengine.com), or in a good [English dictionary](http://www.onelook.com).



<!---
Filename: 100-020-About\_Course-0000-Chapter-Title.md
-->

## About the Course



<!---
Filename: 100-020-About\_Course-0070-About\_This\_Course.md
-->

### About the Course

*Automating System Administration with CFEngine 3 (5 days)*

Requirements: No knowledge of CFEngine or configuration management is
required, only basic knowledge of system administration.

Hardware Requirements: Bring a laptop with wi-fi capability so you can access the Internet.

At the End of this Course You Will Be Able To: automate system administration using CFEngine 3.



<!---
Filename: 100-020-About\_Course-0070-discussion\_question.md
-->

### Discussion Question

What problems would you like to solve with automation?



<!---
Filename: 100-030-Why\_Automation-0000-Chapter-Title.md
-->

## Why Automation?

> Every time someone logs onto a system by hand, they jeopardize everyone's understanding of the system. 
> 
> --- Mark Burgess, author of CFEngine


Benefits of automation:

- decreases labor costs
- increases quality of IT services
- frees humans from drudgery, to focus on more challenging work

See "Why Automation?" in [CFEngine 3 Tutorial (archived)](https://auth.cfengine.com/archive/manuals/cf3-tutorial#Why-automation_003f)



<!---
Filename: 100-040-Why\_CFEngine-0000-Chapter-Title.md
-->

## Why CFEngine?

- Maturity (since 1993, now in its third generation)
- Small footprint (can run everywhere and run often)
- Security (check NVD, we beat the pants off our competition due to a more secure design)
  - [CFEngine in NVD](http://web.nvd.nist.gov/view/vuln/search-results?query=cfengine&search_type=all&cves=on)
  - [Puppet in NVD](http://web.nvd.nist.gov/view/vuln/search-results?query=puppet&search_type=all&cves=on)
- The only configuration management tool based on science (author is a theoretical physicist turned Computer Science researcher)

To learn more, see [20 Years of CFEngine](http://markburgess.org/blog_principles.html), by Mark Burgess.



<!---
Filename: 100-060-CFEngine\_Components-0000-Chapter-Title.md
-->

## CFEngine Components



<!---
Filename: 100-060-CFEngine\_Components-0400-The\_Agent\_cf\_promises\_and\_Cf\_agent.md
-->

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



<!---
Filename: 100-060-CFEngine\_Components-0410-The\_Executor\_cf\_execd.md
-->


### Executor
**cf-execd**
: Used to run cf-agent on a regular (and user-configurable) basis, and to handle its output.



<!---
Filename: 100-060-CFEngine\_Components-0420-Networking\_cfserverd\_cfkey\_cfrunagent.md
-->


### Inter-Node Communication

**cf-serverd**
: File server, used to distribute files; listens for network requests for additional runs of the local agent.  

**cf-key**
: Key generation tool, used on every host to create public/private key pairs for secure communication.

**cf-runagent**
: Remote run agent, is used to execute cf-agent on a remote machine.  cf-runagent does not keep any promises, but instead is used to ask another machine to do so.

**cf-hub**
: CFEngine Enterprise only, used to collect reports from hosts (connects to remote cf-serverd).



<!---
Filename: 100-060-CFEngine\_Components-0430-cfmonitord\_cfknow\_cfreport\_cfhub.md
-->


### Miscellaneous components

**cf-monitord**
:
Passive monitoring agent, collects information about the status of your system (which can be reported or used to influence when promises are enforced).

The following add-on tools have to be installed separately:


**cf-deploy**
: Policy deployment automation tool.

**reindent.pl**
: Source code reformatter (like "tidy").  In contrib/.

**cf-locate**
: Locate bundles in CFEngine source code.  In contrib/.

**cf-profiler**
: Profiler (measures how long your bundles take to run so you can find and tune any slow spots)

**cf-profile.pl**
: Alternative profiler from Jon-Henrik (https://github.com/cfengineers-net/cf-profile)



<!---
Filename: 100-060-CFEngine\_Components-0435-cfengine-versions.md
-->

### CFEngine Packages


**cfengine-community**
: Open-source product, also known as CFEngine Core.

The commercial product is called CFEngine Enterprise. This is CFEngine Core, plus Enterprise extensions (such as Reporting, native Windows build, etc.)


The original name for the first generation of the CFEngine Enterprise product was "Nova" and this is still reflected in the name of the packages:


**cfengine-nova-hub**
: Core plus Mission Portal (which is Report Collection system and an Admin GUI on an Apache/PHP/PostgreSQL stack with a Redis cache for report collection)


**cfengine-nova**
: Core plus Enterprise extensions (e.g. reporting)



<!---
Filename: 100-060-CFEngine\_Components-0440-examination\_of\_cfengine\_rpm.md
-->

### Inspect Package of the CFEngine Core

- Download Core package:

```bash
wget https://cfengine-package-repos.s3.amazonaws.com/community_binaries/\
cfengine-community-3.7.1-1.el6.x86_64.rpm
```
or download from [CFEngine](https://cfengine.com/product/community/)

- Examine Core package:

```bash
rpm -q --filesbypkg cfengine-community-3.7.1-1.el6.x86_64.rpm | less
```



<!---
Filename: 100-065-Enterprise-0000-Chapter-Title.md
-->

## CFEngine Enterprise - Reporting



<!---
Filename: 100-065-Enterprise-0010-how\_enterprise\_works.md
-->

How CFEngine Enterprise works:

1. Hubs pull policy from version control (e.g. Git)
2. Hosts pull policy from hubs and execute it and create inventory and compliance reports
3. Hubs download inventory/compliance reports from hosts and aggregate them 
4. Humans use hub UI to gain insight into infrastructure:

  - promise compliance (including outliers)
  - changes (repairs)
  - standard and custom inventory
  - reporting interface (custom reports)

CFEngine Enterprise introduces additional components:

- Hub (report collection)
- Mission Portal (Admin/Reporting GUI)



<!---
Filename: 100-110-Lab\_VMs-0000-Chapter-Title.md
-->

## Setting Up Your Lab Environment



<!---
Filename: 100-110-Lab\_VMs-0010-VMs.md
-->

Setup two VMs to do the course exercises.

Follow [CFEngine's Vagrant guide](https://docs.cfengine.com/latest/guide-installation-and-configuration-general-installation-installation-enterprise-vagrant.html) to create your lab environment
complete with two VMs and the latest version of CFEngine Enterprise

The VMs need to be able to get out to the Internet to install
packages.

Ensure your VMs have Internet access:

```bash
ping google.com
```

Some companies allow Internet access only through proxies in Web
browser. You will need access from the command line.



<!---
Filename: 100-140-Installing\_CFE\_Hub-0000-Chapter-Title.md
-->

## Installing CFEngine



<!---
Filename: 100-140-Installing\_CFE\_Hub-0050-Lab\_setup.md
-->

To do the exercises, each student should have two VMs:

One to play the role of the Hub, and one to play the role of a Host
connected to that Hub.

CFEngine itself is multiplatform. The examples in this collection
have been tested on RHEL 6.  If you're not sure what OS to install
on your VMs, we recommend you install the same OS as you use in
production and let us know if you have any trouble.



<!---
Filename: 100-140-Installing\_CFE\_Hub-0055-Installing\_CFE\_Hub.exr.md
-->

### Installing CFEngine on your Hub VM

- Ensure your Hub VM has an FQDN hostname (required by Hub package)

  - Add line for FQDN hostname, e.g. "1.2.3.4 alpha.example.com"

```bash
vi /etc/hosts
```
  - Set hostname to FQDN:

```bash
/bin/hostname alpha.example.com
```

- Download hub package

```bash
wget https://cfengine-package-repos.s3.amazonaws.com/enterprise/\
Enterprise-3.7.1/hub/redhat_6_x86_64/cfengine-nova-hub-3.7.1-1.x86_64.rpm
```

If the above URL stops working, you can download the hub package
from [CFEngine.com](http://cfengine.com/download/)

- Install the hub package.

```bash
rpm -ihv ./cfengine-nova-hub-3.7.1-1.x86_64.rpm
```

- Bootstrap the hub to itself:

```bash
cf-agent -B <hostname>
```

NOTE: Bootstrapping performs a key exchange to establish a trust
relationship so that the host can download policy updates from
the hub, and the hub can download inventory and compliance reports
from the host.

- Login to hub admin UI over HTTPS (admin/admin) 

- Change the admin UI password so the VM doesn't get compromised
(Admin -> Settings -> User Management -> Change password)



<!---
Filename: 100-140-Installing\_CFE\_Hub-0060-Installing\_CFE\_host.exr.md
-->

### Installing CFEngine on your 2nd VM (the managed host)

- Ensure your Host VM has an FQDN hostname.
```bash
vi /etc/hosts
/bin/hostname <hostname.domain>
```

- Download host package.
```bash
wget https://cfengine-package-repos.s3.amazonaws.com/enterprise/Enterprise-3.7.1/\
agent/agent_rhel6_x86_64/cfengine-nova-3.7.1-1.x86_64.rpm
```

- Install host package.
```bash
rpm -ihv ./cfengine-nova-3.7.1-1.x86_64.rpm
```

- Bootstrap the host to the hub:
```bash
cf-agent -B <hub IP address>
```

- Go to hub admin UI and within 5-10 minutes the hosts indicator at the top should go from 1 to 2.



<!---
Filename: 100-150-Policy\_Flows-0000-Chapter-Title.md
-->

## Policy Flows



<!---
Filename: 100-150-Policy\_Flows-0050-Policy\_Flow.md
-->

### Policy Flow Diagram

The policy distribution point is /var/cfengine/masterfiles on a policy server.

TIP: Keep your policy in a Version Control System.

![policy flow diagram 1](images/figures/policy_flow_server.pdf)
![policy flow diagram 2](images/figures/policy_flow.pdf)
![policy flow diagram 3](images/figures/policy_flow_clients.pdf)



<!---
Filename: 100-170-Installing\_Examples-0000-Chapter-Title.md
-->

## Installing the Collection

This chapter takes us through installing everything needed to use the collection
and do the exercises.



<!---
Filename: 100-170-Installing\_Examples-0150-GitHub\_URL.md
-->

### Using git

We keep these examples on GitHub and may update them during or after class.

With git, you can download the updates during or after class.



<!---
Filename: 100-170-Installing\_Examples-0160-Install\_git.exr.md
-->

### Installing git

On RHEL/Centos 6:
```bash
yum install git
```

On Debian/Ubuntu:
```bash
apt-get install git
```



<!---
Filename: 100-170-Installing\_Examples-0180-Downloading\_VSA\_Examples\_collection.md
-->

### Downloading examples

Download Aleksey's CFEngine Tutorial repository from GitHub:

```bash
git clone git://github.com/atsaloli/cf3-tutorial.git 
```

Go to the Training Examples directory:

```bash
cd source
```



<!---
Filename: 100-170-Installing\_Examples-0190-Updating\_VSA\_Examples\_collection.md
-->

### Updating Examples

If the instructor updates the examples during class and pushes the
updates to GitHub, run the following to pull in the updates:

```bash
git pull
```



<!---
Filename: 100-180-Installing\_Syntax\_Highlighter-0000-Chapter-Title.md
-->

## Installing Syntax Highlighter



<!---
Filename: 100-180-Installing\_Syntax\_Highlighter-0260-Syntax\_highlighting\_in\_VIM.md
-->

Use a syntax highlighter to catch errors early. This will save you time and trouble.

### Syntax Highlighting in vim

You can install the CFEngine 3 syntax highlighter for vim using the
following shell script, or visit [Code Editors](http://www.cfengine.com/cfengine-code-editors/) on cfengine.com.



<!---
Filename: 100-180-Installing\_Syntax\_Highlighter-0263-install\_syntax\_highlighter.exr.md
-->

### Vim syntax highlighter installation script

We provide a shell script that will install the vim syntax highlighter:

```bash
yum install vim
sh 150-080-Installing_Syntax_Highlighter-0265-Install_Vim_Plugin_CLASSONLY.sh
vim hello_world.cf
```



<!---
Filename: 100-180-Installing\_Syntax\_Highlighter-0270-Syntax\_highlighting\_in\_EMACS.md
-->

### Emacs

See ["Learning CFEngine 3"](http://shop.oreilly.com/product/0636920022022.do) book or the [Code Editors](http://cfengine.com/cfengine-code-editors/) page on cfengine.com



<!---
Filename: 100-180-Installing\_Syntax\_Highlighter-0280-Syntax\_highlighting\_exercise.exr.md
-->

### Verify Syntax Highlighter Has Pretty Colors

Open "hello\_world.cf" in your file editor and ensure you see the pretty
colors of syntax highlighting.

```bash
vim hello_world.cf
```



<!---
Filename: 100-190-Using\_Examples-0000-Chapter-Title.md
-->

## Using the Collection



<!---
Filename: 100-190-Using\_Examples-0240-Running\_the\_examples.md
-->

### Running the examples

All of the examples are shipped as standalone CFEngine 3 files which
you can run on the command-line by specifying the path to the input
file with the *-f* switch:

```bash
cf-agent -f ./create_file.cf
```



<!---
Filename: 100-190-Using\_Examples-0245-Running\_the\_examples.exr.md
-->

### Run the "Create File" example:

```bash
cf-agent -f ./create_file.cf
```



<!---
Filename: 100-190-Using\_Examples-0250-Running\_the\_examples.md
-->

### Running the Examples: Inform Mode

We recommend adding *-I* to turn on Inform mode, to inform of
changes made to the system.  By default CFEngine won't inform of changes
as reports at scale (e.g. tens of thousands of systems) can be overwhelming.
However, while learning, it's educational to know when CFEngine makes changes
and what those changes are.

Example:

```bash
cf-agent -I -f ./create_file.cf
```



<!---
Filename: 100-190-Using\_Examples-0255-Running\_the\_examples.exr.md
-->

### Inform Mode

Run the "Create File" example with "Inform" on:

```bash
rm /tmp/test
cf-agent -I -f ./create_file.cf
```



<!---
Filename: 100-190-Using\_Examples-0290-List\_contents.exr.md
-->

### List contents

List the collection contents:

I've created a shell script to list the collection
contents. It indents the part and chapter headings
to provide a sort of Table of Contents.

Try running it:

```bash
./l.sh
```

Notice the content is structured (the files are numbered).
The materials proceed in sequence from basic to advanced.

However, if you need to find something, the quickest way may be to just grep for it, e.g. to find an example of `process_stop`:

```bash
grep -l process_stop *.cf
```

If the `l.sh` script does not work on your system, use

```bash
ls *.cf
```

and [let me know](mailto:aleksey@verticalsysadmin.com).


