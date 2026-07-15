# Calcurse hook policy

The production calendar uses two small lifecycle hooks around a bounded local
synchronization wrapper. Both hooks request the same two-way operation under
one lock; the phase names control timing, not synchronization direction. This
is pseudocode, not deployable account configuration:

```text
pre-load:
  acquire one local lock
  run one bounded two-way synchronization
  report failure without replacing local configuration

post-save:
  acquire the same local lock
  run one bounded two-way synchronization
  preserve a visible failure result for retry
```

The wrapper owns the real executable path, account selection, credential
lookup, timeout, and logging policy. None of those values belongs in this
snapshot.
