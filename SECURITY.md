# Security policy

This repository must contain only curated public material.

## Reporting

Please use GitHub's private vulnerability reporting feature for an accidental
credential, personal endpoint, machine identity, private address, or other
sensitive value. Do not open a public issue containing the value, even if it
has already been removed from the current branch: Git history and caches may
still retain it.

Documentation mistakes and non-sensitive configuration issues may use the
normal issue tracker.

## Publication boundary

The public tree is rendered from a separate hand-reviewed source directory. Its
verifier rejects unexpected files, unsafe file modes, broken relative links,
and common identity, network, credential, and secret-assignment patterns.
GitHub secret scanning and push protection add another layer.

These checks reduce risk but do not replace human review. Production account
configuration, secrets, trust material, and machine-local state are never valid
contributions to this repository.
