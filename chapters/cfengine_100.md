
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

All our examples are standalone and runnable. If you have
trouble with any of them, please let me know!



<!---
Filename: 100-010-About\_Collection-0140-Using\_this\_collection.md
-->

### Online materials

My course "Automating System Administration using CFEngine 3" is
based on demonstration of "CFEngine Essentials" examples, along with
discussion, lab exercises, and a policy-writing workshop.

I'm now putting these materials online to make it easier for
infrastructure engineers to learn CFEngine 3, to build a stable
civilization.



<!---
Filename: 100-010-About\_Collection-0145-collection\_scripts.md
-->

### Using the examples

The materials are arranged in logical sequence for study.

You may also use them to find examples of a specific
feature or promise attribute; and you are welcome to
seed your policy set with any of these examples. 



<!---
Filename: 100-010-About\_Collection-0150-Feedback\_wanted.md
-->

### Feedback Wanted

If these examples are helpful, if you have any questions,
or would like to contribute an example, please email me
at aleksey (at) verticalsysadmin.com

### Training and Professional Services
I'm available for on-site training and consulting.



<!---
Filename: 100-010-About\_Collection-148-run\_the\_examples.md
-->

### Run the Examples

Try out and run the examples. Modify them. Do the provided
exercises to practice using this new tool and to get to know
it.

Work your way through the materials until you understand them
and have done the provided exercises. There are additional
exercises at the end of the tutorial, or just start writing
your own code!

### Look up any unfamiliar terms
Misunderstood or not understood terms can block understanding.
Look up unfamiliar terms in the [CFEngine Reference Manual](http://docs.cfengine.com), or in a good [English dictionary](http://www.onelook.com).



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

Hardware requirements: Bring a laptop with wi-fi capability so you can access the Internet.

At the end of this course you will be able to:
* Automate system administration (server setup, maintenance and compliance reporting),
* Create a trustworthy and reliable computing services infrastructure.



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

### Syntax Checker

**cf-promises**
: Syntax checker.

```bash
    cf-promises -f ./your_policy.cf
```
Every CFEngine component runs cf-promises on policy files before reading them in.


### Agent

**cf-agent**
: The CFEngine component that audits and makes any needed repairs to your system system. Actually does the work, as far as configuration management is concerned.

```bash
   cf-agent -f ./your_policy.cf
```



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

**cf-consumer**
:
CFEngine Enterprise only, drains Redis cache into Postgres database


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

The name for the first generation of the CFEngine Enterprise product was "Nova" and this is still reflected in the name of the packages:

**cfengine-nova**
: Core plus Enterprise extensions (Reporting, native Windows build, etc.)

**cfengine-nova-hub**
: Core plus Enterpise extensions plus Mission Portal (which is Report Collection system and an Admin GUI on an Apache/PHP/PostgreSQL stack with a Redis cache for report collection)

Packages for systems not supported by cfengine.com (e.g. MacOS, FreeBSD, Android, etc.) can be obtained from [www.cfengineers.net](http://www.cfengineers.net) (e.g. HP-UX)



<!---
Filename: 100-060-CFEngine\_Components-0440-examination\_of\_cfengine\_rpm.md
-->

### Inspect Package of the CFEngine Core

- Download Core package:

```bash
wget https://cfengine-package-repos.s3.amazonaws.com/community_binaries/\
cfengine-community-3.7.1-1.el6.x86_64.rpm
```
or get it from [CFEngine](https://cfengine.com/product/community/)

- Examine package:

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

\begin{aside}
\label{aside:exercise_1}
\heading{Install CFEngine on your Hub VM}


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


\end{aside}
<!---                 
Filename: 100-140-Installing\_CFE\_Hub-0060-Installing\_CFE\_host.exr.md
-->

\begin{aside}
\label{aside:exercise_2}
\heading{Install CFEngine on your 2nd VM (the managed host)}


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


\end{aside}

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

\begin{aside}
\label{aside:exercise_3}
\heading{Install git}


On RHEL/Centos 6:
```bash
yum install git
```

On Debian/Ubuntu:
```bash
apt-get install git
```


\end{aside}

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

\begin{aside}
\label{aside:exercise_4}
\heading{Install CFEngine syntax highlighter for the vim editor}


We provide a shell script that will install the vim syntax highlighter:

```bash
yum install vim
sh 100-180-Installing_Syntax_Highlighter-0265-Install_Vim_Plugin.sh
vim hello_world.cf
```


\end{aside}
\begin{codelisting}
\codecaption{100-180-Installing\_Syntax\_Highlighter-0265-Install\_Vim\_Plugin.sh}
```bash, options: "linenos": false
#!/bin/sh
#
# Run this shell script on your Hub VM to add Neil Watson's
# CFEngine 3 syntax highlighter (minus folding and keyword
# abbreviations) to your .vimrc


cat <<EOF >> $HOME/.vimrc

" -------- start of .vimrc settings from Vertical Sysadmin
" training examples collection
"
" Neil Watson recommends installing functions Getchar and Eatchar


" function Getchar
fun! Getchar()
  let c = getchar()
  if c != 0
    let c = nr2char(c)
  endif
  return c
endfun

" function Eatchar
fun! Eatchar(pat)
  let c = Getchar()
  return (c =~ a:pat) ? '' : c
endfun

" Turn on syntax highlighting for CFEngine 3 files
filetype plugin on
syntax enable
au BufRead,BufNewFile *.cf set ft=cf3

" Disable folding so it does not confuse students not familiar with it
if exists("&foldenable")
	set nofoldenable 
endif

" disable abbreviations so it does not confuse students not familiar with it
let g:DisableCFE3KeywordAbbreviations=0

" -------- end of .vimrc settings from Vertical Sysadmin training examples
" collection
EOF

echo Installing vim plugin for CFEngine syntax highlighting

mkdir -p ~/.vim/ftplugin  ~/.vim/syntax 

wget -O ~/.vim/syntax/cf3.vim \
      --no-check-certificate \
      https://github.com/neilhwatson/vim_cf3/raw/master/syntax/cf3.vim

wget -O ~/.vim/ftplugin/cf3.vim \
      --no-check-certificate \
      https://github.com/neilhwatson/vim_cf3/raw/master/ftplugin/cf3.vim
```
\end{codelisting}

<!---
Filename: 100-180-Installing\_Syntax\_Highlighter-0270-Syntax\_highlighting\_in\_EMACS.md
-->

### Emacs

See ["Learning CFEngine 3"](http://shop.oreilly.com/product/0636920022022.do) book or the [Code Editors](http://cfengine.com/cfengine-code-editors/) page on cfengine.com

### Exercise


<!---                 
Filename: 100-180-Installing\_Syntax\_Highlighter-0280-Syntax\_highlighting\_exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_5}
\heading{Install Syntax Highlighter}


* Install CFEngine 3 syntax highlighter for your favorite editor

* Open "hello\_world.cf" in your editor and ensure you see the pretty
colors of syntax highlighting.  E.g.:

```bash
vim hello_world.cf
```


\end{aside}

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

If you don't specify the path to your file, CFEngine will look for
it in the default policy directory which is /var/cfengine/inputs/
if you are running `cf-agent` as "root", and $HOME/.cfagent/inputs/
if you are running it as a regular user.

We assume you will be running all examples and
doing all exercises as "root".

Note: CFEngine normally runs as "root" but it can be run as non-root, and
some large organizations even run it as both root and non-root on
the same system (running off different policies from different divisions 
of the organization, e.g. base config versus application-specific
config).

CFEngine agent requires a list of bundles to evaluate (a bundle is a
group of promises). If you are using CFEngine version older than 3.7,
you will need to specify the list of bundles to run using the *-b* switch:

```bash
cf-agent -f ./create_file.cf -b main
```

To find out your CFEngine version, use the *-V* switch which is also
available in long form as *--version*:

```bash
# cf-agent -V
CFEngine Core 3.7.1
CFEngine Enterprise 3.7.1
#
```

Here we see the free open-source core ("CFEngine Core") is version 3.7.1 and so is the commercial extension ("CFEngine Enterprise"). 


<!---                 
Filename: 100-190-Using\_Examples-0245-Running\_the\_examples.exr.md
-->

\begin{aside}
\label{aside:exercise_6}
\heading{Run an example CFEngine file}


```bash
cf-agent -f ./create_file.cf
```


\end{aside}

<!---
Filename: 100-190-Using\_Examples-0250-Running\_the\_examples.md
-->

### Running the Examples: Inform Mode

By default, CFEngine doesn't inform you of changes it makes as reports at scale (e.g. tens of thousands of systems) can be overwhelming.

However, while learning, it's educational to know when CFEngine makes changes
and what those changes are.

You can use the *-I* switch to turn on Inform mode so that CFEngine informs of
changes it makes to your system:

Example:

```bash
cf-agent -I -f ./create_file.cf
```


<!---                 
Filename: 100-190-Using\_Examples-0255-Running\_the\_examples.exr.md
-->

\begin{aside}
\label{aside:exercise_7}
\heading{Inform Mode}


Run the "Create File" example with "Inform" mode:

```bash
rm /tmp/test
cf-agent -I -f ./create_file.cf
```


\end{aside}
<!---                 
Filename: 100-190-Using\_Examples-0290-List\_contents.exr.md
-->

\begin{aside}
\label{aside:exercise_8}
\heading{List collection contents using "l.sh"}


I've created a shell script to list the collection
contents. It indents the part and chapter headings
to provide a sort of Table of Contents.

Try running it:

```bash
./l.sh
```

Notice the content is structured (the files are numbered).
The materials proceed in sequence from basic to advanced.

If the `l.sh` script does not work on your system
(or you don't like it), you can just run:

```bash
ls *.cf
```


\end{aside}
<!---                 
Filename: 100-190-Using\_Examples-0300-grep.exr.md
-->

\begin{aside}
\label{aside:exercise_9}
\heading{To find something, the quickest way may be to grep for it.}


E.g. to find an example of `process_stop`:

```bash
grep -l process_stop *.cf
```


\end{aside}
