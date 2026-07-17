# Maintaining the public snapshot

The public repository is a one-way publication target. It never reads the
private workstation repository, and the two repositories never share Git
history.

## Source-to-public flow

```text
private curated source
  → exact allowlist and freshness check
  → deterministic render into an empty directory
  → path-only comparison with public main
  → public feature branch with a noreply author identity
  → pull request
  → required verify job
  → squash merge
```

Safe production files such as a color palette may be exact-copy inputs.
Material that needs redaction or explanation remains manually curated. A small
set of source digests marks which private documents and configurations were
reviewed; when one changes, publication stops until its public counterpart is
reviewed and the digest is deliberately updated.

## Update cadence

The snapshot is refreshed after a meaningful user-visible workstation change
or a completed architectural stage, not after every private commit. This keeps
ordinary configuration work fast while preventing the showcase from silently
drifting for long periods.

Dependabot pull requests are update signals, not an alternate source of truth.
The maintainer applies an accepted workflow-pin change to the private curated
source, renders a fresh snapshot, and only then merges the public pull request.
The same rule applies to outside documentation or configuration proposals.

## Package-maintenance boundary

The ordinary Homebrew path detects cached candidates from clean development
`main`, creates one reviewed maintenance intent only when work exists, and
reuses the normal canary-first convergence path. An empty candidate list
creates no branch, commit, publication, or installed-software change.

A lower-level read-only plan and explicit preparation path remains available
for combined Homebrew, mise, and Neovim plugin revisions. Preparation changes
only reviewable repository state. Homebrew is limited to declared formulae and
casks; mise keeps configured ranges; Neovim follows its lockfile. App Store
updates remain an explicit local administrator action.

This boundary prevents a package refresh from silently becoming cleanup,
project dependency churn, service activation, synchronization, or backup. A
failed selected package scope remains a resumable deployment result rather
than an invitation to rerun unrelated checks.

## Review rules

- Render only from the curated source directory, never from live home files.
- Keep output limited to the exact public manifest.
- Review path-only additions, modifications, and deletions before content.
- Never include private source commit IDs, internal remotes, accounts, or hosts.
- Keep public updates on feature branches; do not push directly to `main`.
- Let GitHub create the verified squash commit on signed-commit-protected `main`.
- Revert an incorrect publication through a public pull request.

The exporter performs no network access, commit, push, or merge. GitHub remains
the independent review and CI boundary for public publication.
