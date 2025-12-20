
<!---
Filename: 200-000-Part-Title-0000-basic\_concepts\_and\_terms.md
-->

# Basic Concepts and Terminology



<!---
Filename: 200-020-Promises-0000-Chapter-Title.md
-->

## Promises



<!---
Filename: 200-020-Promises-0050-Promise.md
-->

### Promise

**Promise**
: A promise is a statement of intention.

Trust is an economic time-saver. If you can't trust you have to verify,
and that is expensive.

To improve trust we make promises. A promise is the documentation of
an intention to act or behave in some manner. This is what we need to
learn to trust systems.



<!---
Filename: 200-020-Promises-0051-everything\_is\_a\_promise.md
-->

#### Everything is a promise

CFEngine works on a simple notion of promises. Everything in CFEngine
can be thought of as a promise to be kept by different resources in
the system.

CFEngine manages every intended system outcome as "promises" to be kept.

Promises are always things that can be kept and repaired continuously,
on a real time basis, not just once at install-time.




<!---
Filename: 200-020-Promises-0052-Promise\_outcomes.md
-->

#### Every promise in CFEngine can have one of three outcomes

**KEPT**
: No repairs needed, system matches spec (is already converged).

**REPAIRED**
: system did not match spec, and CFEngine repaired it (converged it).

**NOTKEPT**
: system did not match spec, and CFEngine could not repair (converge) it.



<!---
Filename: 200-020-Promises-0053-handling\_promise\_outcomes.md
-->

#### Handling Promise Outcomes

**NOTKEPT** outcomes likely require attention!

**REPAIRED** outcomes _may_ require attention (especially if they keep recurring).




<!---
Filename: 200-020-Promises-0055-Promises\_plus\_Patterns\_equals\_Configuration.BOOKONLY.md
-->

### Promises + Patterns = Configuration

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



<!---
Filename: 200-020-Promises-0060-Policy.md
-->

### Policy
 
**Policy**
: A policy is a set of intentions about the system, coded as a list of
promises. A policy is not a standard, but the result of specific
organizational management decisions.



<!---
Filename: 200-020-Promises-0065-simple\_promise\_files\_nologin.md
-->

### Example simple promise - create a file

```cfengine3
files:

    "/etc/nologin" 

        create  => "true",
        comment => "Prevent regular users from logging in
                    during maintenance";
```



<!---
Filename: 200-020-Promises-0070-the\_most\_basic\_form\_of\_a\_promise.md
-->

### The Basic Form of a Promise

```cfengine3
promise_type:

       "promiser" 

            promise details;

```



<!---
Filename: 200-020-Promises-0090-Promise\_Type.md
-->


### Some Basic Promise Types

Here are some basic promise types:

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




<!---
Filename: 200-020-Promises-0100-Promise\_Type\_example.BOOKONLY.md
-->

The promise type is always followed by a single colon.


```cfengine3, options:  "hl_lines": [1]
files:    

    "/etc/nologin" 

        create  => "true",
        comment => "Prevent non-root users from logging in";
```



<!---
Filename: 200-020-Promises-0110-Promiser.md
-->

### Promiser

**Promiser**
: The promiser is the part of the system that will be affected by the
promise. (We are affected by the promises we make.)



<!---
Filename: 200-020-Promises-0120-Promiser\_example.BOOKONLY.md
-->


The promiser follows the promise type, and is in double quotes.

```cfengine3, options:  "hl_lines": [3]
files:

    "/etc/nologin"  

        create  => "true",
        comment => "Prevent non-root users from logging in";
```



<!---
Filename: 200-020-Promises-0130-hashrocket.md
-->

What is the `=>` symbol in the promise details?

It is used to specify key/value relationships.


```cfengine3
files:    

    "/etc/nologin" 

        create  => "true",
        comment => "Prevent non-root users from logging in";
```

It is called "hashrocket" in Ruby (because it is used in Ruby hashes),
"fat comma" in Perl, and "double arrow" in PHP.

You can call it whatever you like. :)

Reference:
* <https://en.wikipedia.org/wiki/Fat_comma>



<!---
Filename: 200-030-Bodies\_and\_Bundles-0000-Chapter-Title.md
-->

## Bodies and Bundles

The basic building blocks of the CFEngine languages are bodies and bundles.

That is to say, all CFEngine policy source code consists from bundles
and bodies.

Let's define these two terms and really understand the difference
between them.



<!---
Filename: 200-030-Bodies\_and\_Bundles-0130-Body.md
-->

### Definition: "Body"

> *Body*
> - The main part of a book or document, not including the introduction,
> notes, or appendices (parts added at the end).
> 
> --- Macmillan Dictionary

Examples of bodies: body of a letter, body of a contract.

The body is where the details are.



<!---
Filename: 200-030-Bodies\_and\_Bundles-0132-Definition\_of\_Attribute.md
-->

### Definition: "Attribute"

> *Attribute*
> - a quality or feature of someone or something
>
> *Quality*
> - a feature of a thing, substance, place etc.
> "the addictive qualities of tobacco"
>
> *Feature*
> - an important part or aspect of something
> "Each room has its own distinctive features."
>
> --- Macmillan Dictionary



<!---
Filename: 200-030-Bodies\_and\_Bundles-0135-Promise\_Body.md
-->

### Promise Body

**Promise body**
: A promise body is a collection of promise attributes that details and
constrains the nature of the promise.



<!---
Filename: 200-030-Bodies\_and\_Bundles-0140-Promise\_Body\_example\_2.BOOKONLY.md
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



<!---
Filename: 200-030-Bodies\_and\_Bundles-0150-Promise\_Bundle.md
-->

### Promise Bundle

**Promise bundle**
: A promise bundle is a group of one or more logically related _promises_.

The bundle allows us to group related promises, and to refer to such
groups by name.

You can group promises into bundles in the way that makes the most
sense for your environment and team.

For example:

- `base_os_config` bundle contains promises to configure the base OS,

- `httpd` bundle contains promises to install and configure Apache httpd,

- `inventory_java_mem` contains promises to collect information about
Java memory settings (starting and max memory size) used to ensure legacy
hosts for the same applications have the same settings (actual example).




<!---
Filename: 200-030-Bodies\_and\_Bundles-0152-Promise\_Bundle.md
-->

#### Bundle Type

Bundles always have a type which must be specified when you declare a bundle.

The type corresponds to a specific CFEngine component which handles those promises.

| Bundle Type | Contains promises for |
|-------------|-----------------------|
| `agent`     | *cf-agent*, the part of CFEngine that checks and repairs system state
| `edit_xml`  | *cf-agent*, promises about file contents when they are structured data (XML)
| `edit_line` | *cf-agent*, promises about file contents when they are unstructured data (not XML)
| `monitor`   | *cf-monitord*, the system monitoring component installed on every host
| `server`    | *cf-serverd*, the policy/file server component - usually ACL promises
| `common`    | Any CFEngine component - usually used to define variables and to classify hosts




<!---
Filename: 200-030-Bodies\_and\_Bundles-0153-Promise\_Bundle.md
-->

#### Declaring a Bundle; Bundle Syntax

Bundles consist of the keyword `bundle` followed by bundle _type_ and _name_, followed by curly braces that enclose the promises, e.g.:

```cfengine3
bundle agent my_example {

...  # your promises code goes here

}
```



<!---
Filename: 200-040-Declarative-0000-Chapter-Title.md
-->

## CFEngine Language is Declarative



<!---
Filename: 200-040-Declarative-0170-declarative\_vs\_imperativ\_sandwich\_example.md
-->

### "Declarative" vs. "Imperative" Programming

> A declarative programming style ... is often unfamiliar to newcomers, even
> if they are experienced programmers in other domains. Most commonly-used
> programming languages are examples of imperative programming, in
> which the programmer must describe a specific algorithm or process.
> Declarative programming instead focuses on describing the particular
> state or goal to be achieved.
> --- [Mike English](http://spin.atomicobject.com/2012/09/13/from-imperative-to-declarative-system-configuration-with-puppet/)



<!---
Filename: 200-040-Declarative-0180-declarative\_vs\_imperative.md
-->

### Examples

#### Imperative - Make me a Sandwich!
> Spread peanut butter on one slice of bread. Set this slice of bread on a plate, face-up. Spread jelly on another slice of bread. Place this second slice of bread on top of the first, face-down. Bring me the sandwich.
> --- [Mike English](http://spin.atomicobject.com/2012/09/13/from-imperative-to-declarative-system-configuration-with-puppet/)

#### Declarative - The Sandwich I Desire.
> There should be a sandwich on a
> plate in front of me... It should have only peanut butter and jelly
> between the two slices of bread.
> --- [Mike English](http://spin.atomicobject.com/2012/09/13/from-imperative-to-declarative-system-configuration-with-puppet/)




<!---
Filename: 200-040-Declarative-0185-declarative\_4\_system\_admin.md
-->

### Declarative Programming for System Administration
> Declarative programming is a more natural fit for managing system
> configuration. We want to be talking about whether or not MySQL is
> installed on this machine or Apache on that machine, not whether yum
> install mysql-server has been run here or apt-get install apache2
> there. It allows us to express intent more clearly in the code. It is
> also less tedious to write and can even be more portable to different
> platforms.
> --- [Mike English](http://spin.atomicobject.com/2012/09/13/from-imperative-to-declarative-system-configuration-with-puppet/)




<!---
Filename: 200-040-Declarative-0190-Declarative\_intent.md
-->

### Declarative has a higher Signal to Syntax Ratio

A declarative language allows us to express intent more clearly, to let
the intent shine through the syntax of the code.  It allows us to have
a higher Signal to Syntax ratio.



<!---
Filename: 200-040-Declarative-0200-Convergence.md
-->

Convergence

> *Convergence*
> - coming to a desired end state
>
> --- Mark Burgess, http://markburgess.org/blog_cd.html

![Convergence](images/figures/convergence.pdf)

> *converge*
>
> - come from different directions and meet at (a place).
> "half a million sports fans will converge on the capital"
>
> - (of a number of things) gradually change so as to become similar or develop something in common.
>
> --- OxfordDictionaries.com



<!---
Filename: 200-040-Declarative-0210-Thinking\_Declaratively.md
-->

### Writing CFEngine policies

1. State the sysadmin problem.

2. Envision the desired end state.

3. Translate the desired end state into CFEngine Policy Language.



<!---                 
Filename: 200-040-Declarative-0220-Thinking\_Declaratively.exr.md
-->

\begin{aside}
\label{aside:exercise_8}
\heading{Learning to Think Declaratively}


1. State an actual sysadmin problem you need to solve

2. Envision the desired end state; state what the desired end result is, in a declarative (not procedural) fashion.

In other words, focus on the WHAT and let CFEngine handle the HOW (which may vary from OS to OS anyway).


\end{aside}
