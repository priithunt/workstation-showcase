# Architecture

## Source of truth

Shared workstation configuration lives in Git. A primary remote and a mirror
must resolve to the same commit before either Mac applies a change. The
deployment checkout is separate from the development checkout, which keeps
unfinished work away from the live configuration.

## Machine roles

The system has two logical roles:

| Role | Responsibility |
| --- | --- |
| Canary | Applies and verifies a reviewed commit first; coordinates the secondary |
| Secondary | Applies the identical approved commit after the canary |

Roles are not permanent hardware identities. Replacement hardware can assume a
role only after a candidate bootstrap and reviewed inventory cutover.

## Data ownership

Different data classes use different sources of truth:

| Data | Owner |
| --- | --- |
| Source code and workstation configuration | Git |
| Active documents and notes | File synchronization with versioning |
| Shell history | End-to-end encrypted history synchronization |
| Mail and calendar | Their upstream services |
| Historical machine recovery | Encrypted backups |
| Passwords and recovery material | A dedicated secret manager |

Synchronization is not backup, and configuration management is not secret
distribution. Keeping those boundaries explicit makes failures easier to
reason about.

## Restricted cross-Mac control

The canary reaches the secondary through a forced-command protocol with pinned
host trust. It does not provide an interactive shell, file transfer,
forwarding, or arbitrary command execution. Responses are bounded and expose
only the action result, exact commit, role, and path-only drift.
