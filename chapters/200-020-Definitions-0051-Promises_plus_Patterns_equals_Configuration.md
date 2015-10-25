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
