# aerc example

The public snapshot includes a portable styleset and a deliberately small
navigation keymap. Production account, transport, and credential configuration
stays machine-local. The private workstation repository does manage reviewed
folder policy, but personal mailbox names and mappings are omitted here.

The palette intentionally matches the terminal layer so message state remains
easy to scan without changing colors between WezTerm, tmux, and aerc. Account
behavior is verified separately because a visually harmless file and a mailbox
mapping have very different risk.

[`binds.conf`](binds.conf) demonstrates only generic movement and view actions.
It does not include account-specific archive, delete, or folder behavior.
