#### Every promise in CFEngine can have one of three outcomes

**KEPT**
: No repairs needed, system matches spec (is already converged).

**REPAIRED**
: system did not match spec, and CFEngine repaired it (converged it).

**NOTKEPT**
: system did not match spec, and CFEngine could not repair (converge) it.

NOTKEPT outcomes likely require attention!

REPAIRED outcomes _may_ require attention (especially if they keep recurring).

