
<!---
Filename: 150-000-Part-Title-0000-Lab\_Setup.md
-->

# Lab Setup



<!---
Filename: 150-110-Lab\_VMs-0000-Chapter-Title.md
-->

## Setting Up Your Lab Environment



<!---
Filename: 150-140-Installing\_CFE\_Hub-0000-Chapter-Title.md
-->

## Installing CFEngine




<!---
Filename: 150-140-Installing\_CFE\_Hub-0050-Lab\_setup.md
-->

### Lab Infrastructure

#### Two VMs

To do the exercises, each student should have two VMs:

- one to play the role of the Hub (policy distribution point),
- another to play the role of a managed Host.

Normally, you would have multiple hosts managed from a single hub.
Two VMs gives us a CFEngine-managed system in miniature.




<!---
Filename: 150-140-Installing\_CFE\_Hub-0051-Lab\_setup2.md
-->

#### Vagrant

CFEngine provides a turnkey solution with Vagrant.

You can follow [CFEngine's Vagrant
guide](https://docs.cfengine.com/latest/guide-installation-and-configuration-general-installation-installation-enterprise-vagrant.html)
to create your lab environment complete with two VMs and the latest
version of CFEngine Enterprise.

Otherwise the following details the lab requirements (if you want to put
together your own lab instead of using the CFEngine Vagrant lab).




<!---
Filename: 150-140-Installing\_CFE\_Hub-0052-Lab\_setup3.md
-->

#### Roll Your Own Lab

##### Operating System

CFEngine is multiplatform.

If you're not sure what OS to install on your VMs, we recommend you
install the same OS as you use in production and let us know if you have
any trouble.

The examples in this collection have been tested on RHEL 8.




<!---
Filename: 150-140-Installing\_CFE\_Hub-0053-Lab\_setup4.md
-->

##### Network Access

The VMs need to be able to get out to the Internet to install
packages.

Ensure your VMs have Internet access:

```bash
ping google.com
```

Some companies allow Internet access only through proxies in Web
browser. You will need access from the command line.

Your systems also need to be able to reach each other on tcp/5308
(CFEngine).



<!---
Filename: 150-140-Installing\_CFE\_Hub-0055-Installing\_CFE\_Hub.md
-->

### First VM -- the Hub

TODO - this needs to be updated for 3.12 or newer

- Ensure your Hub VM has an FQDN hostname (required by Hub package).
Add line for FQDN hostname, e.g. "1.2.3.4 alpha.example.com"

```bash
vi /etc/hosts
```
Set hostname to FQDN:

```bash
/bin/hostname alpha.example.com
```



<!---
Filename: 150-140-Installing\_CFE\_Hub-0056-Installing\_CFE\_Hub.md
-->

Get hub package URL from [CFEngine.com/download/](http://cfengine.com/download/)


- Download hub package
```bash
wget ...
```

- Install the hub package.
```bash
rpm -ihv ./cfengine-nova-hub-*.rpm
```



<!---
Filename: 150-140-Installing\_CFE\_Hub-0057-Installing\_CFE\_Hub.md
-->

- Bootstrap the hub to itself:
```bash
cf-agent -B <hostname>
```

- Run the agent once to finish setup:
```bash
cf-agent
```

NOTE: Bootstrapping performs a key exchange to establish a trust
relationship so that the host can download policy updates from
the hub, and the hub can download inventory and compliance reports
from the host.

- Login to hub admin UI over HTTPS (admin/admin)

- Change the admin UI password so the VM doesn't get compromised
(Admin -> Settings -> User Management -> Change password)



<!---
Filename: 150-140-Installing\_CFE\_Hub-0060-Installing\_CFE\_host.md
-->

### Second VM - a Managed Host

TODO -- this needs to be updated for 3.12 or newer

Install CFEngine on your 2nd VM (the managed host).

- Download host package.

```bash
wget \
https://cfengine-package-repos.s3.amazonaws.com/\
enterprise/Enterprise-3.7.1/\
agent/agent_rhel6_x86_64/cfengine-nova-3.7.1-1.x86_64.rpm
```



<!---
Filename: 150-140-Installing\_CFE\_Hub-0070-Installing\_CFE\_host\_2.md
-->

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
Filename: 150-150-Policy\_Flows-0000-Chapter-Title.md
-->

## Policy Flows



<!---
Filename: 150-150-Policy\_Flows-0050-Policy\_Flow.md
-->

### Policy Flow Diagram

#### Definitions

**Policy server**
: A server that shares CFEngine files (policy, data, templates, scripts, binaries) with the rest of the infrastructure using cf-serverd. Also called the hub.

**Policy distribution point**
: The default policy distribution point is /var/cfengine/masterfiles on the policy server. Policy comes from here; in other words, the managed hosts get their policy from /var/cfengine/masterfiles on the policy server (also called the hub).

**Inputs directory**
: The inputs directory is where CFEngine looks for its policy files (defaults to /var/cfengine/inputs).



<!---
Filename: 150-150-Policy\_Flows-0055-Policy\_Flow.md
-->

#### Policy Distribution Flow

The CFEngine agent runs twice in each cycle:
- Checks for policy updates (and copies them from /var/cfengine/masterfiles/ on the hub to the local /var/cfengine/inputs/)
- Runs the policy in /var/cfengine/inputs/

This "caching" of policy makes CFEngine resilient to network outages. CFEngine uses the network opportunistically.

The default schedule is the agent runs every 5 minutes.

So you can update hundreds of thousands of servers within minutes. Very powerful!



<!---
Filename: 150-150-Policy\_Flows-0060-tip.md
-->


TIP: Keep your policy in a version control system, such as git.




<!---
Filename: 150-150-Policy\_Flows-0070-policy-server-itself.BOOKONLY.md
-->

#### Policy Server

Here is the policy distribution flow on the the policy server itself:

![policy flow diagram 1](images/figures/policy_flow_server.pdf)

The policy server itself runs the agent, to manage itself.
The above diagram shows how that agent gets updates.



<!---
Filename: 150-150-Policy\_Flows-0080-one-host.BOOKONLY.md
-->

#### One Host

Let's add a host (client) to the picture:

![policy flow diagram 2](images/figures/policy_flow.pdf)




<!---
Filename: 150-150-Policy\_Flows-0090-many-hosts.BOOKONLY.md
-->

#### Many Hosts

Let's add more hosts:

![policy flow diagram 3](images/figures/policy_flow_clients.pdf)




<!---
Filename: 150-170-Installing\_Examples-0000-Chapter-Title.md
-->

## Installing the Collection

This chapter takes us through installing everything needed to use the collection
and do the exercises.



<!---
Filename: 150-170-Installing\_Examples-0150-GitHub\_URL.md
-->

### Using git

We keep these examples on GitHub and may update them during or after class.

With git, you can download the updates during or after class.


<!---                 
Filename: 150-170-Installing\_Examples-0160-Install\_git.exr.md
-->

\begin{aside}
\label{aside:exercise_1}
\heading{#### Install git}


On RHEL/Centos:
```bash
yum install -y git
```

On Debian/Ubuntu:
```bash
apt-get install -y git
```


\end{aside}

<!---
Filename: 150-170-Installing\_Examples-0180-Downloading\_VSA\_Examples\_collection.md
-->

### Downloading examples

Download Aleksey's CFEngine Tutorial repository from GitHub:

```bash
git clone git://github.com/atsaloli/cf3-tutorial.git
```

Go to the Training Examples directory:

```bash
cd cf3-tutorial/source
```



<!---
Filename: 150-170-Installing\_Examples-0190-Updating\_VSA\_Examples\_collection.md
-->

### Updating Examples

If the instructor updates the examples during class and pushes the
updates to GitHub, run the following to pull in the updates:

```bash
git pull
```



<!---
Filename: 150-180-Installing\_Syntax\_Highlighter-0000-Chapter-Title.md
-->

## Installing Syntax Highlighter



<!---
Filename: 150-180-Installing\_Syntax\_Highlighter-0260-Syntax\_highlighting\_in\_VIM.md
-->

Use a syntax highlighter to catch errors early. This will save you time and trouble.

### Syntax Highlighting in vim

You can install the CFEngine 3 syntax highlighter for vim using the
following shell script, or visit [Code Editors](http://www.cfengine.com/cfengine-code-editors/) on cfengine.com.


<!---                 
Filename: 150-180-Installing\_Syntax\_Highlighter-0263-install\_syntax\_highlighter.exr.md
-->

\begin{aside}
\label{aside:exercise_2}
\heading{Install CFEngine syntax highlighter for the vim editor}


We provide a shell script that will install the vim syntax highlighter:

```bash
sh 150-180-Installing_Syntax_Highlighter-0265-Install_Vim_Plugin.sh
```


\end{aside}
\begin{codelisting}
\codecaption{150-180-Installing\_Syntax\_Highlighter-0265-Install\_Vim\_Plugin.sh}
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
Filename: 150-180-Installing\_Syntax\_Highlighter-0270-Syntax\_highlighting\_in\_EMACS.md
-->

### Emacs

See ["Learning CFEngine"](https://leanpub.com/learning-cfengine) book or the [Code Editors](http://cfengine.com/cfengine-code-editors/) page on cfengine.com



<!---                 
Filename: 150-180-Installing\_Syntax\_Highlighter-0280-Syntax\_highlighting\_exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_3}
\heading{Install Syntax Highlighter}


* Install CFEngine 3 syntax highlighter for your favorite editor

* Open "hello\_world.cf" in your editor and ensure you see the pretty
colors of syntax highlighting.  E.g.:

```bash
vim hello_world.cf
```


\end{aside}

<!---
Filename: 150-190-Using\_Examples-0000-Chapter-Title.md
-->

## Using the Collection



<!---
Filename: 150-190-Using\_Examples-0240-Running\_the\_examples.md
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

We assume you will be running all examples and doing all exercises as
"root".

Note: CFEngine normally runs as "root" but it can be run as non-root, and
some large organizations even run it as both root and non-root on
the same system (running off different policies from different divisions 
of the organization, e.g. base config versus application-specific
config).



<!---                 
Filename: 150-190-Using\_Examples-0245-Running\_the\_examples.exr.md
-->

\begin{aside}
\label{aside:exercise_4}
\heading{Run an example CFEngine file}


```bash
cf-agent -f ./create_file.cf
```


\end{aside}

<!---
Filename: 150-190-Using\_Examples-0250-Running\_the\_examples.md
-->

### Running the Examples: Inform Mode

By default, CFEngine doesn't inform you of changes it makes as reports
at scale (e.g. tens of thousands of systems) can be overwhelming.

However, while learning, it's educational to know when CFEngine makes
changes and what those changes are.

You can turn on Inform mode with `cf-agent -I` so that CFEngine informs
you of any changes it makes to your system.


<!---                 
Filename: 150-190-Using\_Examples-0255-Running\_the\_examples.exr.md
-->

\begin{aside}
\label{aside:exercise_5}
\heading{Run the "Create File" example with "Inform" mode enabled:}


```bash
rm /tmp/test
cf-agent -I -f ./create_file.cf
```

What do you see?

Why?


\end{aside}
<!---                 
Filename: 150-190-Using\_Examples-0290-List\_contents.exr.md
-->

\begin{aside}
\label{aside:exercise_6}
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
Filename: 150-190-Using\_Examples-0300-grep.exr.md
-->

\begin{aside}
\label{aside:exercise_7}
\heading{To find something, the quickest way may be to grep for it.}


E.g. to find an example of `process_stop`:

```bash
grep -l process_stop *.cf
```


\end{aside}
