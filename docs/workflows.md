# Configuration workflows

## Everyday path

```text
edit → focused check → commit → one canary convergence command
→ both remotes → canary apply → secondary restricted sync → clean final state
```

A change may start on either Mac. The canary role controls application order,
but it does not have to be the machine where the edit was made. One daily
command publishes a local descendant or receives an identical remote
descendant, applies the canary, selects the secondary action from exact local
approval, and reports all three states. The underlying publisher classifies
fast, standard, and bounded guarded ranges automatically.

## Verification levels

| Level | Examples | Verification |
| --- | --- | --- |
| Fast | Documentation, key bindings, simple configuration | Changed-file checks |
| Standard | Editor plugins, package declarations, language runtimes | Relevant activation and focused check |
| Guarded | Remote control, rollout policy, backup or mail helpers | One assigned verifier and a reusable exact receipt |
| Strict release | Inventory cutover or an unbounded critical change | Signed canary and completion workflow |

Guarded publication binds its one verifier result to the exact base, commit,
changed-path hash, and verifier groups. The canary apply reuses that receipt
instead of rerunning the verifier. The secondary performs only its one focused
host pass when it receives the exact commit.

Read-only checks must also remain non-interactive. A service verifier may
inspect bounded process state and perform a local protocol handshake, but it
must not require `sudo` merely to prove readiness. The strict signed workflow
is reserved for inventory cutovers and changes whose impact cannot be bounded;
ordinary configuration does not inherit that ceremony.

The complete workstation audit is a scheduled or explicitly requested health
check, not a per-commit gate. Documentation and ordinary configuration usually
finish in under a minute; package installation is dominated by the selected
package manager rather than repository ceremony.

## Neovim plugin example

Adding a plugin updates the plugin specification and lock file. The canary
checks the Lua files, applies the managed target, and runs only the Neovim
activation. The secondary receives the same commit and repeats the bounded
activation. Mail synchronization, backup, and unrelated service checks do not
run.

## Package and runtime example

Package discovery and installation are separate operations. A read-only plan
collects cached Homebrew, mise, and App Store candidates without changing
installed software. A preparation command then records only selected Homebrew
or mise maintenance intent and may refresh the Neovim plugin lock in isolated
XDG directories. The normal convergence command applies the reviewed commit
canary-first and then secondary.

```text
ordinary Homebrew: detect cached candidates → one intent commit when needed
→ normal two-Mac convergence

mixed maintenance: plan → select scopes → prepare reviewable Git intent
→ review and commit → normal two-Mac convergence
```

The ordinary Homebrew command requires clean development `main` and identical
cached remote refs. An empty candidate list creates no branch, commit,
publication, or installed-software change. The mixed lower-level path remains
available for Homebrew, mise, and Neovim changes that need manual review.

Homebrew upgrades only formulae and casks declared by the rendered Brewfiles,
without greedy cask updates, automatic application quitting, autoremove, or
forced cleanup. mise stays inside configured version ranges and does not
rewrite project lockfiles. Neovim installs the exact prepared lock revision.
App Store candidates remain visible but manual because their update requires
interactive privileged authority. Mail, calendar, backup, services, and
project dependencies are not changed as package-maintenance side effects.

## Mail or calendar example

A styleset or key binding is an ordinary file change. A transport, folder-map,
or hook change is guarded and receives the mail or calendar subsystem verifier.
Even then, real synchronization is not part of generic configuration
application. It runs through a dedicated command or the reviewed Calcurse
pre-load/post-save hook path.

## Offline secondary

If the secondary is asleep or offline, the approved commit remains on the
remotes and canary as a successful pending state. Running the same command when
the secondary returns reuses completed work and sends the exact commit once. An
uncertain write result is resolved with one read-only status request; a
state-changing action is never retried blindly.

## Quick read-only status

Before changing anything, one local status command summarizes cached
development and deployment refs, Git and configuration drift, package
candidates, and restricted secondary state. It does not fetch, apply, upgrade,
synchronize, back up, or run the full audit. An offline secondary is reported
as attention instead of turning the status command into a failed deployment.

## Public snapshot example

The public showcase has its own path. Curated private content is checked and
rendered offline, compared path-by-path with the public checkout, and proposed
through a public feature branch. Its required CI job validates the exact tree,
file modes, syntax, links, and sensitive-content rules before squash merge.
