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
