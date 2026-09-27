#!/bin/bash
# Mirrors the real repo's entry_point.sh: source a local .env if present
# (so TF_VAR_* exports reach the shell), set up a plugin cache so repeated
# `terraform init` runs don't re-download providers, then hand off to
# whatever command docker run was given.
set -euo pipefail

if [ -f ".env" ]; then
  # shellcheck disable=SC1091
  source ".env"
fi

mkdir -p "${HOME}/.terraform.d/plugin-cache"
cat > "${HOME}/.terraformrc" <<EOF
plugin_cache_dir = "${HOME}/.terraform.d/plugin-cache"
EOF

export WORKING_DIR="${PWD}"

exec "$@"
