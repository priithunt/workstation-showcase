# Contributing

This repository is a curated snapshot rather than the production configuration
or an installer. Small documentation corrections, portable configuration
improvements, and questions about the published design are welcome.

## Pull requests

1. Work on a feature branch.
2. Keep examples portable and free of personal identities or endpoints.
3. Update `manifest.json` when adding or removing a file.
4. Run `scripts/verify-showcase.sh`.
5. Explain the user-facing reason for the change.

Before an accepted contribution is merged, the maintainer ports it into the
private curated source and renders the public snapshot again. This preserves a
single source of truth even though the two repositories do not share Git
history. A public-only correction must not remain on `main`.

Never place a suspected secret in an issue or pull request. Follow
[`SECURITY.md`](SECURITY.md) instead.
