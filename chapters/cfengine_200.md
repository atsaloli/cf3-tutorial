
<!---
Filename: 200-000-Part-Title-0000-Introduction.md
-->

# Introduction

\coloredtext{red}{ 200-000-Part-Title-0000-Introduction.md }


<!---
Filename: 200-010-Introductory\_overview-0000-Chapter-Title.md
-->

## Overview

At this point of the course, a brief introductory lecture is given
introducing CFEngine and the idea of desired state management.

For students doing the correspondence course, please watch:

CFEngine 101 webinar series (Feb 2014)

1. [IT Automation with CFEngine: Business Values and Basic Concepts](https://www.youtube.com/watch?v=Atf5MhjBHpM)

2. [Getting Started with CFEngine](https://www.youtube.com/watch?v=riMkdQKBI0M)

\coloredtext{red}{ 200-010-Introductory\_overview-0000-Chapter-Title.md }


<!---
Filename: 200-010-Introductory\_overview-0032-lifecycle\_of\_a\_machine.BOOKONLY.md
-->

![Alt text](images/figures/lifecycle.pdf)

\coloredtext{red}{ 200-010-Introductory\_overview-0032-lifecycle\_of\_a\_machine.BOOKONLY.md }


<!---
Filename: 200-020-Definitions-0000-Chapter-Title.md
-->

## Definitions

\coloredtext{red}{ 200-020-Definitions-0000-Chapter-Title.md }


<!---
Filename: 200-020-Definitions-0050-Promise.md
-->

### Promise

**Promise**
: A promise is a statement of intention.

Trust is an economic time-saver. If you can't trust you have to verify,
and that is expensive.

To improve trust we make promises. A promise is the documentation of
an intention to act or behave in some manner. This is what we need to
learn to trust systems.

\coloredtext{red}{ 200-020-Definitions-0050-Promise.md }


<!---
Filename: 200-020-Definitions-0051-Promise\_outcomes.md
-->

### Promise Outcomes

CFEngine works on a simple notion of promises. Everything in CFEngine
can be thought of as a promise to be kept by different resources in
the system.

CFEngine manages every intended system outcome as "promises" to be kept.

Promises are always things that can be kept and repaired continuously,
on a real time basis, not just once at install-time.

### Every promise in CFEngine can have one of three outcomes

**KEPT**
: No repairs needed, system matches spec (is already converged).

**REPAIRED**
: system did not match spec, and CFEngine repaired it (converged it).

**NOTKEPT**
: system did not match spec, and CFEngine could not repair (converge) it.

NOTKEPT outcomes likely require attention!

REPAIRED outcomes may require attention (especially if they keep recurring).

\coloredtext{red}{ 200-020-Definitions-0051-Promise\_outcomes.md }


<!---
Filename: 200-020-Definitions-0051-Promises\_plus\_Patterns\_equals\_Configuration.md
-->

## Promises + Patterns = Configuration

Combining promises with patterns to describe where and when promises
should apply is how CFEngine works.

It can be represented by this formula:

{$$}
{Promises} {+} {Patterns} = {Configuration}
{/$$}

For example, you may want all hosts at your primary site to have
home directories mounted over autofs but not at your DR site;
or you may want to run extra file-integrity checking on hosts 
in your DMZ.  In both examples, you have a promise and a pattern
as to when and where it applies.

\coloredtext{red}{ 200-020-Definitions-0051-Promises\_plus\_Patterns\_equals\_Configuration.md }


<!---
Filename: 200-020-Definitions-0060-Policy.md
-->

### Policy
 
**Policy**
: A policy is a set of intentions about the system, coded as a list of
promises. A policy is not a standard, but the result of specific
organizational management decisions.

\coloredtext{red}{ 200-020-Definitions-0060-Policy.md }


<!---
Filename: 200-020-Definitions-0065-simple\_promise\_files\_nologin.md
-->

### Example simple promise - create a file

```cfengine3
files:

    "/etc/nologin" 

        create  => "true",
        comment => "Prevent non-root users from logging in so we can perform maintenance";
```

\coloredtext{red}{ 200-020-Definitions-0065-simple\_promise\_files\_nologin.md }


<!---
Filename: 200-020-Definitions-0070-the\_most\_basic\_form\_of\_a\_promise.md
-->

### The Most Basic Form of a Promise

```cfengine3
promise_type:

       "promiser" 

            attribute1 => value1,
            attribute2 => value2;
```

\coloredtext{red}{ 200-020-Definitions-0070-the\_most\_basic\_form\_of\_a\_promise.md }


<!---
Filename: 200-020-Definitions-0090-Promise\_Type.md
-->


### Basic promise types
**files**
: A promise about a file, including its existence, attributes and contents.

**packages**
: A promise to install (or remove or update or verify) a package.

**processes**
: A promise concerning items in the system process table.

**vars**
: A promise to be a variable, representing a value.

**reports**
: A promise to report a message.

**commands**
: A promise to execute a command.


\coloredtext{red}{ 200-020-Definitions-0090-Promise\_Type.md }


<!---
Filename: 200-020-Definitions-0100-Promise\_Type\_example.md
-->

### Example of Promise Type

`files` followed by a single colon indicates the promise type.

The promise type is always followed by a single colon.


```cfengine3, options:  "hl_lines": [1]
files:    

    "/etc/nologin" 

        create  => "true",
        comment => "Prevent non-root users from logging in";
```

\coloredtext{red}{ 200-020-Definitions-0100-Promise\_Type\_example.md }


<!---
Filename: 200-020-Definitions-0110-Promiser.md
-->

### Promiser

**Promiser**
: The promiser is the part of the system that will be affected by the
promise. (We are affected by the promises we make.)

\coloredtext{red}{ 200-020-Definitions-0110-Promiser.md }


<!---
Filename: 200-020-Definitions-0120-Promiser\_example.md
-->

### Example of Promiser

'/etc/nologin' is the promiser (the affected system object).

```cfengine3, options:  "hl_lines": [3]
files:

    "/etc/nologin"  

        create  => "true",
        comment => "Prevent non-root users from logging in";
```

\coloredtext{red}{ 200-020-Definitions-0120-Promiser\_example.md }


<!---
Filename: 200-020-Definitions-0130-Body.md
-->

### Definition: "Body"

**Body**
: The main part of a book or document, not including the introduction,
notes, or appendices (parts added at the end). --- Macmillan Dictionary

Examples of bodies: body of a letter, body of a contract.

The body is where the details are.

\coloredtext{red}{ 200-020-Definitions-0130-Body.md }


<!---
Filename: 200-020-Definitions-0132-Definition\_of\_Attribute.md
-->

### Definition: "Attribute"

> *Feature*
> - an important part or aspect of something
> "Each room has its own distinctive features."
> 
> *Quality*
> - a feature of a thing, substance, place etc.
> "the addictive qualities of tobacco"
> 
> *Attribute*
> - a quality or feature of someone or something
>
> --- Macmillan Dictionary

\coloredtext{red}{ 200-020-Definitions-0132-Definition\_of\_Attribute.md }


<!---
Filename: 200-020-Definitions-0135-Promise\_Body.md
-->

### Promise Body

A promise body is a collection of promise attributes that details and
constrains the nature of the promise.

\coloredtext{red}{ 200-020-Definitions-0135-Promise\_Body.md }


<!---
Filename: 200-020-Definitions-0140-Promise\_Body\_example\_2.md
-->

Example of Promise Body

The last three lines constitute the promise body.

```cfengine3, options:  "hl_lines": [5,6,7]
files:

    "/var/cfengine/i_am_alive" 

        create  => "true",                          
        touch   => "true",                         
        comment => "Prove CFEngine is running.";  
```

\coloredtext{red}{ 200-020-Definitions-0140-Promise\_Body\_example\_2.md }


<!---
Filename: 200-020-Definitions-0150-Promise\_Bundle.md
-->

### Promise Bundle

The promise bundle is one of the basic building blocks of configuration
in CFEngine.

A promise bundle is a group of one or more logically related promises.

The bundle allows us to group related promises, and to refer to such
groups by name.

You can group promises into bundles in the way that makes the most
sense for your environment and team.

For example:

- *base_os_config* bundle contains promises to configure the base OS,

- *httpd* bundle contains promises to install and configure Apache httpd,

- *inventory_java_mem* contains promises to collect information about Java memory settings (starting and max memory size) used to ensure legacy hosts for the same applications have the same settings.


Bundles always have a type which must be specified when you declare a bundle.

The type corresponds to a specific CFEngine component which handles those promises.

| Bundle     | Contains promises for |
|------------|-----------------------|
| `agent`    | *cf-agent*, the part of CFEngine that checks and repairs system state
| `edit_xml` | *cf-agent* promises about file contents when they are structured data (XML)
| `edit_line`| *cf-agent* promises about file contents when they are unstructured data (everything else)
| `monitor`  | *cf-monitord*, the system monitoring component installed on every host
| `server`   | *cf-serverd*, the policy/file server component - usually ACL promises
| `common`   | Any CFEngine component - usually used to define variables and to classify systems (group hosts by type). More on classification in Chapter 4.

Bundles consist of the keyword `bundle` followed by bundle type and name, followed by curly braces that enclose the promises, e.g.:

```cfengine3
bundle agent my_example
{

...  # your promises code goes here

}
```

Notice our syntax highlighter puts language keywords in green.

\coloredtext{red}{ 200-020-Definitions-0150-Promise\_Bundle.md }


<!---
Filename: 200-020-Definitions-0170-declarative\_vs\_imperativ\_sandwich\_example.md
-->

### "Declarative" vs. "Imperative" Programming

> A declarative programming style ... is often unfamiliar to newcomers, even
> if they are experienced programmers in other domains. Most commonly-used
> programming languages are examples of imperative programming, in
> which the programmer must describe a specific algorithm or process.
> Declarative programming instead focuses on describing the particular
> state or goal to be achieved.
> --- [Mike English](http://spin.atomicobject.com/2012/09/13/from-imperative-to-declarative-system-configuration-with-puppet/)

\coloredtext{red}{ 200-020-Definitions-0170-declarative\_vs\_imperativ\_sandwich\_example.md }


<!---
Filename: 200-020-Definitions-0180-declarative\_vs\_imperative.md
-->

### Examples

> Make Me a Sandwich! (Imperative) Spread peanut butter on one slice of
> bread. Set this slice of bread on a plate, face-up. Spread jelly on
> another slice of bread. Place this second slice of bread on top of the
> first, face-down.  Bring me the sandwich.
> 
> The Sandwich I Desire. (Declarative) There should be a sandwich on a
> plate in front of me... It should have only peanut butter and jelly
> between the two slices of bread.
> --- [Mike English](http://spin.atomicobject.com/2012/09/13/from-imperative-to-declarative-system-configuration-with-puppet/)


### Declarative Programming for System Administration
> Declarative programming is a more natural fit for managing system
> configuration. We want to be talking about whether or not MySQL is
> installed on this machine or Apache on that machine, not whether yum
> install mysql-server has been run here or apt-get install apache2
> there. It allows us to express intent more clearly in the code. It is
> also less tedious to write and can even be more portable to different
> platforms.
> --- [Mike English](http://spin.atomicobject.com/2012/09/13/from-imperative-to-declarative-system-configuration-with-puppet/)

\coloredtext{red}{ 200-020-Definitions-0180-declarative\_vs\_imperative.md }


<!---
Filename: 200-020-Definitions-0190-Declarative\_intent.md
-->

### Declarative has a higher Signal to Syntax Ratio

A declarative language allows us to express intent more clearly, to let
the intent shine through the syntax of the code.  It allows us to have
a higher Signal to Syntax ratio.

\coloredtext{red}{ 200-020-Definitions-0190-Declarative\_intent.md }


<!---
Filename: 200-020-Definitions-0200-Convergence.md
-->

Convergence

**Convergence**
: coming to a desired end state  (Mark Burgess, http://markburgess.org/blog_cd.html)

![Convergence](images/figures/convergence.pdf)

**converge**
: come from different directions and meet at (a place).
"half a million sports fans will converge on the capital"
: (of a number of things) gradually change so as to become similar or develop something in common.
OxfordDictionaries.com

\coloredtext{red}{ 200-020-Definitions-0200-Convergence.md }


<!---
Filename: 200-020-Definitions-0210-Thinking\_Declaratively.md
-->

### Writing CFEngine policies

1. State the sysadmin problem.

2. Envision the desired end state.

3. Translate the desired end state into CFEngine Policy Language.


\coloredtext{red}{ 200-020-Definitions-0210-Thinking\_Declaratively.md }

<!---                 
Filename: 200-020-Definitions-0220-Thiking\_Declaratively.exr.md
-->

\begin{aside}
\label{aside:exercise_9}
\heading{Learning to Think Declaratively}


1. State an actual sysadmin problem you need to solve

2. Envision the desired end state; state what the desired end result is, in a declarative (not procedural) fashion.

In other words, focus on the WHAT and let CFEngine handle the HOW (which may vary from OS to OS anyway).


\end{aside}
\coloredtext{red}{ 200-020-Definitions-0220-Thiking\_Declaratively.exr.md }
