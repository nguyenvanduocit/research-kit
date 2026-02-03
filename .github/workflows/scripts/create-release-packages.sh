#!/usr/bin/env bash
set -euo pipefail

# create-release-packages.sh
# Build Research Kit template release archives for supported AI assistants.
# Usage: .github/workflows/scripts/create-release-packages.sh <version>
#   Version argument should include leading 'v'.
#   Optionally set AGENTS env var to limit what gets built.
#     AGENTS: space or comma separated subset of: claude codex (default: all)
#   Examples:
#     AGENTS=claude $0 v1.0.0
#     AGENTS="claude,codex" $0 v1.0.0

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version-with-v-prefix>" >&2
  exit 1
fi
NEW_VERSION="$1"
if [[ ! $NEW_VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version must look like v0.0.0" >&2
  exit 1
fi

echo "Building release packages for $NEW_VERSION"

GENRELEASES_DIR=".genreleases"
mkdir -p "$GENRELEASES_DIR"
rm -rf "$GENRELEASES_DIR"/* || true

rewrite_paths() {
  sed -E \
    -e 's@(/?)memory/@.research/memory/@g' \
    -e 's@(/?)scripts/@.research/scripts/@g' \
    -e 's@(/?)templates/@.research/templates/@g'
}

copy_agents() {
  local output_dir=$1
  mkdir -p "$output_dir"

  if [[ -d templates/agents ]]; then
    for agent_template in templates/agents/*.md; do
      [[ -f "$agent_template" ]] || continue
      local name content
      name=$(basename "$agent_template" .md)
      content=$(cat "$agent_template" | rewrite_paths)
      echo "$content" > "$output_dir/${name}.md"
    done
    echo "Copied agents -> $output_dir"
  fi
}

copy_skills() {
  local output_dir=$1
  mkdir -p "$output_dir"

  if [[ -d templates/skills ]]; then
    for skill_template in templates/skills/*.md; do
      [[ -f "$skill_template" ]] || continue
      local name content
      name=$(basename "$skill_template" .md)
      content=$(cat "$skill_template" | rewrite_paths)
      echo "$content" > "$output_dir/${name}.md"
    done
    echo "Copied skills -> $output_dir"
  fi
}

generate_commands() {
  local output_dir=$1
  mkdir -p "$output_dir"

  for template in templates/commands/*.md; do
    [[ -f "$template" ]] || continue
    local name description script_command body
    name=$(basename "$template" .md)

    file_content=$(tr -d '\r' < "$template")
    description=$(printf '%s\n' "$file_content" | awk '/^description:/ {sub(/^description:[[:space:]]*/, ""); print; exit}')
    script_command=$(printf '%s\n' "$file_content" | awk '/^[[:space:]]*sh:[[:space:]]*/ {sub(/^[[:space:]]*sh:[[:space:]]*/, ""); print; exit}')

    if [[ -z $script_command ]]; then
      script_command=""
    fi

    body=$(printf '%s\n' "$file_content" | sed "s|{SCRIPT}|${script_command}|g")

    # Remove scripts: section from frontmatter
    body=$(printf '%s\n' "$body" | awk '
      /^---$/ { print; if (++dash_count == 1) in_frontmatter=1; else in_frontmatter=0; next }
      in_frontmatter && /^scripts:$/ { skip_scripts=1; next }
      in_frontmatter && /^[a-zA-Z].*:/ && skip_scripts { skip_scripts=0 }
      in_frontmatter && skip_scripts && /^[[:space:]]/ { next }
      { print }
    ')

    body=$(printf '%s\n' "$body" | sed 's/{ARGS}/$ARGUMENTS/g' | rewrite_paths)
    echo "$body" > "$output_dir/research.$name.md"
  done
}

build_package() {
  local agent=$1
  local base_dir="$GENRELEASES_DIR/research-${agent}-package"
  echo "Building $agent package..."
  mkdir -p "$base_dir"

  local SPEC_DIR="$base_dir/.research"
  mkdir -p "$SPEC_DIR"

  # Copy memory
  [[ -d memory ]] && { cp -r memory "$SPEC_DIR/"; echo "Copied memory -> .research"; }

  # Copy bash scripts only
  if [[ -d scripts/bash ]]; then
    mkdir -p "$SPEC_DIR/scripts"
    cp -r scripts/bash "$SPEC_DIR/scripts/"
    chmod +x "$SPEC_DIR/scripts/bash"/*.sh 2>/dev/null || true
    echo "Copied scripts/bash -> .research/scripts"
  fi

  # Copy templates (excluding commands/, agents/, and skills/)
  if [[ -d templates ]]; then
    mkdir -p "$SPEC_DIR/templates"
    rsync -a templates/ "$SPEC_DIR/templates/" --exclude='commands/' --exclude='agents/' --exclude='skills/' --exclude='vscode-settings.json'
    echo "Copied templates -> .research/templates"
  fi

  case $agent in
    claude)
      mkdir -p "$base_dir/.claude/commands"
      mkdir -p "$base_dir/.claude/agents"
      mkdir -p "$base_dir/.claude/skills"
      generate_commands "$base_dir/.claude/commands"
      copy_agents "$base_dir/.claude/agents"
      copy_skills "$base_dir/.claude/skills"
      ;;
    codex)
      mkdir -p "$base_dir/.codex/prompts"
      generate_commands "$base_dir/.codex/prompts"
      ;;
  esac

  ( cd "$base_dir" && zip -r "../research-kit-${agent}-${NEW_VERSION}.zip" . )
  echo "Created $GENRELEASES_DIR/research-kit-${agent}-${NEW_VERSION}.zip"
}

# Supported agents
ALL_AGENTS=(claude codex)

# Parse AGENTS env var
if [[ -n ${AGENTS:-} ]]; then
  IFS=', ' read -ra AGENT_LIST <<< "$AGENTS"
  for agent in "${AGENT_LIST[@]}"; do
    if [[ ! " ${ALL_AGENTS[*]} " =~ " ${agent} " ]]; then
      echo "Error: unknown agent '$agent' (allowed: ${ALL_AGENTS[*]})" >&2
      exit 1
    fi
  done
else
  AGENT_LIST=("${ALL_AGENTS[@]}")
fi

echo "Agents: ${AGENT_LIST[*]}"

for agent in "${AGENT_LIST[@]}"; do
  build_package "$agent"
done

echo "Archives in $GENRELEASES_DIR:"
ls -1 "$GENRELEASES_DIR"/research-kit-*-"${NEW_VERSION}".zip
