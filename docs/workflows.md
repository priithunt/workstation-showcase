# Configuration workflows

## Everyday path

```text
edit → focused check → commit → both remotes
→ canary apply → secondary restricted sync → clean final state
```

A change may start on either Mac. The canary role controls application order,
but it does not have to be the machine where the edit was made. One publish
command classifies fast, standard, and bounded guarded ranges automatically.

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

A Homebrew declaration and a mise runtime pin have different owners. Changing
the representative package baseline validates the Brewfile and performs only
the package scope that was reviewed. Changing Node, Go, Java, or pnpm validates
the mise configuration and installs only the declared runtime. Project
dependencies and unrelated global tools are not upgraded as a side effect.

## Mail or calendar example

A styleset or key binding is an ordinary file change. A transport, folder-map,
or hook change is guarded and receives the mail or calendar subsystem verifier.
Even then, real synchronization is not part of generic configuration
application. It runs through a dedicated command or the reviewed Calcurse
pre-load/post-save hook path.

## Offline secondary

If the secondary is asleep or offline, the approved commit remains on the
remotes and canary. When the secondary returns, the controller sends the exact
commit once. An uncertain write result is resolved with a read-only status
request before any retry.

## Public snapshot example

The public showcase has its own path. Curated private content is checked and
rendered offline, compared path-by-path with the public checkout, and proposed
through a public feature branch. Its required CI job validates the exact tree,
file modes, syntax, links, and sensitive-content rules before squash merge.
