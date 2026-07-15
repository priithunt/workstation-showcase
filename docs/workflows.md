# Configuration workflows

## Everyday path

```text
edit → focused check → commit → both remotes
→ canary apply → secondary restricted sync → clean final state
```

A change may start on either Mac. The canary role controls application order,
but it does not have to be the machine where the edit was made.

## Verification levels

| Level | Examples | Verification |
| --- | --- | --- |
| Fast | Documentation, key bindings, simple configuration | Changed-file checks |
| Standard | Editor plugins, package declarations, language runtimes | Relevant activation and focused check |
| Guarded | Remote control, rollout policy, backup or mail helpers | One assigned subsystem verifier |
| Strict release | Inventory cutover or an unbounded critical change | Signed canary and completion workflow |

Guarded targets are verified in a detached worktree before the canonical
checkout fast-forwards. A failing verifier therefore leaves the active commit
unchanged.

## Neovim plugin example

Adding a plugin updates the plugin specification and lock file. The canary
checks the Lua files, applies the managed target, and runs only the Neovim
activation. The secondary receives the same commit and repeats the bounded
activation. Mail synchronization, backup, and unrelated service checks do not
run.

## Offline secondary

If the secondary is asleep or offline, the approved commit remains on the
remotes and canary. When the secondary returns, the controller sends the exact
commit once. An uncertain write result is resolved with a read-only status
request before any retry.
