#!/usr/bin/env bash
set -euo pipefail

root="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
manifest="$root/manifest.json"
temporary="$(mktemp -d "${TMPDIR:-/tmp}/workstation-showcase-public.XXXXXX")"
trap 'rm -rf "$temporary"' EXIT

[[ -d "$root" && ! -L "$root" && -f "$manifest" && ! -L "$manifest" ]]
jq -e '
  keys == ["files", "history_mode", "kind", "schema_version"] and
  .schema_version == 1 and .kind == "curated-workstation-showcase" and
  .history_mode == "snapshot-only" and
  (.files | type == "array" and length > 0 and length == (unique | length) and . == sort)
' "$manifest" >/dev/null

if find "$root" -path "$root/.git" -prune -o -type l -print -quit | grep -q .; then
	echo "Public snapshot contains a symlink." >&2
	exit 1
fi

jq -r '.files[]' "$manifest" >"$temporary/expected"
find "$root" -path "$root/.git" -prune -o -type f -print |
	sed "s#^$root/##" | LC_ALL=C sort >"$temporary/actual"
cmp -s "$temporary/expected" "$temporary/actual" || {
	echo "Public snapshot inventory differs from manifest.json." >&2
	exit 1
}

blocked_literals=(
	"gitea"'.pilvekeskus.ee'
	"internal"'.example.invalid'
	"Priits"'-MacBook-Pro'
	"/"'Users/'
)
credential_pattern='-----BEGIN [A-Z ]*PRIVATE KEY-----|gh[pousr]_[A-Za-z0-9_]{20,}|github'_'pat_[A-Za-z0-9_]{20,}|ssh-(rsa|ed25519)[[:space:]]+[A-Za-z0-9+/]{20,}={0,3}'
private_network_pattern='(^|[^0-9])(10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|192\.168\.[0-9]{1,3}\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[01])\.[0-9]{1,3}\.[0-9]{1,3})([^0-9]|$)'

while IFS= read -r path; do
	file="$root/$path"
	[[ -f "$file" && ! -L "$file" && "$(wc -c <"$file" | tr -d '[:space:]')" -le 262144 ]]
	for literal in "${blocked_literals[@]}"; do
		grep -Fq -- "$literal" "$file" && {
			echo "Public snapshot contains a blocked literal: $path" >&2
			exit 1
		}
	done
	grep -Eq -- "$credential_pattern" "$file" && {
		echo "Public snapshot contains credential-like material: $path" >&2
		exit 1
	}
	grep -Eq -- "$private_network_pattern" "$file" && {
		echo "Public snapshot contains a private network address: $path" >&2
		exit 1
	}
done <"$temporary/expected"

echo "Public workstation showcase verified."
