#!/bin/bash

# Part of installing ALE to get linting in Vim, mostly for Coderabbit yamls.
#
# ALE's schema validation (see dot_vimrc) needs yaml-language-server in PATH.
# --prefix ~/.local keeps it out of root-owned dirs, so no sudo on mac or linux.
# Re-runs only when this file changes, so edit it (e.g. this line) to force an upgrade.
set -e

if ! command -v npm >/dev/null; then
  echo "npm not found: install node, then re-run chezmoi apply" >&2
  exit 1
fi

npm install -g --prefix ~/.local yaml-language-server

# ALE's doc/tags isn't in its repo; build it so :help ale works.
vim -u NONE -es -c 'helptags ~/.vim/pack/plugins/start/ale/doc' -c 'q'
