# Continuous verification

The production repository has one small CI workflow that is intentionally
separate from the two-Mac rollout path. It provides an independent source
signal without making ordinary personal configuration changes wait for a full
machine audit.

## What it checks

The workflow runs on an Apple Silicon macOS runner and verifies only bounded,
host-independent material:

- shell, JSON, formatting, and policy syntax for the selected source paths;
- deterministic rendering of the active machine inventory;
- synthetic rendering of a future Apple Silicon secondary;
- machine-candidate, lifecycle, restricted-listener, and rollout fixtures;
- the versioned checksum of the restricted dispatcher source.

The active secondary remains unchanged until a real candidate completes its
own bootstrap and inventory cutover. Synthetic rendering proves that the
configuration model accepts the architecture; it does not create a third
production machine or copy an existing device identity.

## What it does not do

CI does not contact either personal Mac, apply chezmoi, install packages,
change services, synchronize mail or files, run backups, or inspect secrets.
It also does not run the complete workstation audit.

The exact local verifier remains the authority for applying a reviewed commit.
CI is an asynchronous check of the mirrored private source, not a second
approval ceremony. Newer updates supersede older in-progress runs, and the
same push is not duplicated as both a branch and pull-request job.
