# Tooling and ownership

A reliable workstation needs more than a package list. Every executable has a
clear owner, and project-specific tools remain with the project that pins them.

## Ownership model

| Layer | Owns | Does not own |
| --- | --- | --- |
| Homebrew | System CLI tools, libraries, and desktop applications | Shared language runtime versions |
| mise | Node, Go, Java, and pnpm used across projects | Project lint and build policy |
| Mason | Neovim-only LSP, DAP, and fallback formatting tools | Terminal-wide runtimes |
| Project | Build wrappers, dependencies, tests, lint, formatting, lockfiles | Machine-wide applications |

The shell resolves mise shims before Homebrew runtime binaries. A Homebrew
formula may still be present as another formula's implementation dependency,
but it does not become a second user-managed runtime.

## CLI map

| Purpose | Tools | Working principle |
| --- | --- | --- |
| Search and navigation | `fzf`, `fd`, `ripgrep`, `zoxide` | Fast discovery with composable text output |
| Files and terminal | `bat`, `eza`, `yazi`, `btop`, `dust`, `duf` | Human-readable inspection without hiding standard tools |
| Git | `git-delta`, `lazygit`, `gh` | Review first; keep Git itself as the source of truth |
| Data and automation | `jq`, `yq`, `just`, `watchexec`, `hyperfine` | Small deterministic commands rather than opaque orchestration |
| Runtimes | `mise`, `uv`, `pipx`, `deno` | Separate shared runtimes, isolated applications, and project environments |
| Documentation | `pandoc`, `glow`, `presenterm`, `mermaid-cli` | Keep operational knowledge close to code |
| Safety | `shellcheck`, `shfmt`, `sops`, `age` | Check scripts and support project-scoped encrypted material |

The representative [`Brewfile`](../config/homebrew/Brewfile) shows the public
baseline. Personal desktop applications and app-store ownership are outside
the snapshot.

## Project rules

- Prefer `./gradlew` and `./mvnw` over global Gradle or Maven installations.
- Keep JavaScript and TypeScript tools in project `devDependencies`.
- Use project environments and lockfiles for Python tools.
- Make local and CI formatting commands identical.
- Treat editor format-on-save as convenience, not as the project's policy owner.

The [`mise` template](../config/mise/config.toml.tmpl) shows shared runtime pins
coming from one reviewed data source. It is intentionally separate from the
package declaration layer.

SOPS and age are available for projects that deliberately adopt encrypted
files. They are not the workstation's credential-distribution or machine-
identity enrollment mechanism; those responsibilities remain with the secret
manager and per-machine setup.
