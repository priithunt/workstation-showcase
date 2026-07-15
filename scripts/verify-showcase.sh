#!/usr/bin/env bash
set -euo pipefail

ci_mode=0
if [[ "${1:-}" == "--ci" ]]; then
  ci_mode=1
  shift
fi
[[ "$#" -le 1 ]] || {
  echo "Usage: verify-showcase.sh [--ci] [ROOT]" >&2
  exit 2
}

root_input="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
[[ -d "$root_input" && ! -L "$root_input" ]] || {
  echo "Public snapshot root must be a real directory." >&2
  exit 1
}
root="$(cd "$root_input" && pwd -P)"
manifest="$root/manifest.json"
temporary="$(mktemp -d "${TMPDIR:-/tmp}/workstation-showcase-public.XXXXXX")"
trap 'rm -rf "$temporary"' EXIT

if ((ci_mode)); then
  for command in git jq luac python3 ruby shellcheck zsh; do
    command -v "$command" >/dev/null 2>&1 || {
      echo "CI verification requires the checker: $command" >&2
      exit 1
    }
  done
fi

file_mode() {
  if [[ "$(uname -s)" == "Darwin" ]]; then
    stat -f '%OLp' "$1"
  else
    stat -c '%a' "$1"
  fi
}

[[ -d "$root" && ! -L "$root" && -f "$manifest" && ! -L "$manifest" ]]
jq -e '
  def safe_manifest_path:
    type == "string" and
    test("^[A-Za-z0-9._/-]+$") and
    (startswith("/") | not) and
    (startswith("./") | not) and
    (endswith("/") | not) and
    (split("/") | all(. != "" and . != "." and . != ".."));
  keys == ["executable_files", "files", "history_mode", "kind", "schema_version"] and
  .schema_version == 2 and .kind == "curated-workstation-showcase" and
  .history_mode == "snapshot-only" and
  (.files | type == "array" and length > 0 and all(safe_manifest_path) and
    length == (unique | length) and . == sort) and
  (.executable_files | type == "array" and length > 0 and
    all(safe_manifest_path) and
    length == (unique | length) and . == sort) and
  ((.executable_files - .files) | length == 0)
' "$manifest" >/dev/null

if find "$root" -path "$root/.git" -prune -o -type l -print -quit | grep -q .; then
  echo "Public snapshot contains a symlink." >&2
  exit 1
fi

jq -r '.files[]' "$manifest" >"$temporary/expected"
jq -r '.executable_files[]' "$manifest" >"$temporary/executable"
find "$root" -path "$root/.git" -prune -o -type f -print |
  sed "s#^$root/##" | LC_ALL=C sort >"$temporary/actual"
cmp -s "$temporary/expected" "$temporary/actual" || {
  echo "Public snapshot inventory differs from manifest.json." >&2
  diff -u "$temporary/expected" "$temporary/actual" >&2 || true
  exit 1
}

git_index_mode=0
if command -v git >/dev/null 2>&1; then
  git_top="$(git -C "$root" rev-parse --show-toplevel 2>/dev/null || true)"
  if [[ -n "$git_top" && "$(cd "$git_top" && pwd -P)" == "$root" ]]; then
    git_index_mode=1
  fi
fi

blocked_literals=(
  "gitea"'.pilvekeskus.ee'
  "internal"'.example.invalid'
  "Priits"'-MacBook-Pro'
  "/"'Users/'
)
credential_pattern='-----BEGIN [A-Z ]*PRIVATE KEY-----|gh[pousr]_[A-Za-z0-9_]{20,}|github'_'pat_[A-Za-z0-9_]{20,}|ssh-(rsa|ed25519)[[:space:]]+[A-Za-z0-9+/]{20,}={0,3}'
private_network_pattern='(^|[^0-9])(10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|192\.168\.[0-9]{1,3}\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[01])\.[0-9]{1,3}\.[0-9]{1,3})([^0-9]|$)'
email_pattern='[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
secret_assignment_pattern='(^|[^A-Za-z0-9_])(password|passwd|passphrase|token|secret|api_key|access_key|client_secret)[[:space:]]*[:=][[:space:]]*[^[:space:]<]+'
uri_userinfo_pattern='[A-Za-z][A-Za-z0-9+.-]*://[^/?#:@[:space:]]+:[^/?#@[:space:]]+@'

while IFS= read -r path; do
  file="$root/$path"
  [[ -f "$file" && ! -L "$file" && "$(wc -c <"$file" | tr -d '[:space:]')" -le 262144 ]]
  expected_mode=644
  grep -Fxq "$path" "$temporary/executable" && expected_mode=755
  actual_mode=""
  if ((git_index_mode)); then
    index_entry="$(git -C "$root" ls-files --stage -- "$path")"
    if [[ -z "$index_entry" ]]; then
      actual_mode="$(file_mode "$file")"
    elif [[ "$(printf '%s\n' "$index_entry" | wc -l | tr -d '[:space:]')" == 1 ]]; then
      case "${index_entry%% *}" in
        100644) actual_mode=644 ;;
        100755) actual_mode=755 ;;
        *) actual_mode="${index_entry%% *}" ;;
      esac
    else
      echo "Public snapshot file is ambiguous in the Git index: $path" >&2
      exit 1
    fi
  else
    actual_mode="$(file_mode "$file")"
  fi
  [[ "$actual_mode" == "$expected_mode" ]] || {
    echo "Public snapshot has an unsafe file mode: $path" >&2
    exit 1
  }
  for literal in "${blocked_literals[@]}"; do
    grep -Fq -- "$literal" "$file" && {
      echo "Public snapshot contains a blocked literal: $path" >&2
      exit 1
    }
  done
  for pattern in "$credential_pattern" "$private_network_pattern" "$email_pattern" \
    "$uri_userinfo_pattern"; do
    grep -Eq -- "$pattern" "$file" && {
      echo "Public snapshot contains sensitive-looking material: $path" >&2
      exit 1
    }
  done
  grep -Eqi -- "$secret_assignment_pattern" "$file" && {
    echo "Public snapshot contains a sensitive-looking assignment: $path" >&2
    exit 1
  }
done <"$temporary/expected"

bash -n "$root/scripts/verify-showcase.sh"
if ((ci_mode)) || command -v shellcheck >/dev/null 2>&1; then
  shellcheck "$root/scripts/verify-showcase.sh"
fi
if ((ci_mode)) || command -v zsh >/dev/null 2>&1; then
  zsh -n "$root/config/shell/zshenv"
  zsh -n "$root/config/shell/zshrc.zsh"
fi
if ((ci_mode)) || command -v luac >/dev/null 2>&1; then
  while IFS= read -r -d '' path; do
    luac -p "$path"
  done < <(find "$root" -path "$root/.git" -prune -o -type f -name '*.lua' -print0)
fi
git config --file "$root/config/git/gitconfig" --list >/dev/null
if ((ci_mode)) || command -v ruby >/dev/null 2>&1; then
  ruby -c "$root/config/homebrew/Brewfile" >/dev/null
  while IFS= read -r -d '' path; do
    ruby -ryaml -e 'YAML.parse_file(ARGV.fetch(0)) or abort("Empty YAML document: #{ARGV.fetch(0)}")' \
      "$path"
  done < <(find "$root" -path "$root/.git" -prune -o -type f \
    \( -name '*.yml' -o -name '*.yaml' \) -print0)
fi

python3 - "$root" <<'PY'
import json
import pathlib
import re
import sys
import tomllib
import urllib.parse

root = pathlib.Path(sys.argv[1]).resolve()
manifest = json.loads((root / "manifest.json").read_text(encoding="utf-8"))
published = [root / relative for relative in manifest["files"]]

for path in (item for item in published if item.suffix == ".json"):
    with path.open("r", encoding="utf-8") as handle:
        json.load(handle)

for path in (
    item for item in published if item.suffix == ".toml" or item.name.endswith(".toml.tmpl")
):
    with path.open("rb") as handle:
        tomllib.load(handle)

link_pattern = re.compile(r"\[[^\]]+\]\(([^)]+)\)")
for path in (item for item in published if item.suffix == ".md"):
    text = path.read_text(encoding="utf-8")
    for raw_target in link_pattern.findall(text):
        target = raw_target.strip().split("#", 1)[0]
        if not target or target.startswith(("http://", "https://", "mailto:")):
            continue
        candidate = (path.parent / urllib.parse.unquote(target)).resolve()
        if root != candidate and root not in candidate.parents:
            raise SystemExit(f"Relative Markdown link escapes the snapshot: {path.relative_to(root)}")
        if not candidate.exists():
            raise SystemExit(
                f"Broken relative Markdown link in {path.relative_to(root)}: {raw_target}"
            )
PY

echo "Public workstation showcase verified."
