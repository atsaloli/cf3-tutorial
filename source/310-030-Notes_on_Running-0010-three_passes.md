CFEngine will make up to three passes through each bundle to speed
convergence to desired state.

Sometimes a promise cannot be repaired because there is a broken
dependency.

CFEngine will make multiple passes in auditing/repairing a system. After
dependencies are repaired, repairs of dependent promises can now succeed.

Run `cf-agent` with the -v switch (verbose) and look for "pass 1", "pass
2", and "pass 3" to observe the three passes.
