#!/usr/bin/env bash

__sdk_env() {
  if [[ -f .sdkrc ]]; then
    __use .sdkrc

    return
  fi

  if [[ -f .tool-versions ]]; then
    __use .tool-versions

    return
  fi

  __sdkman_echo_red 'Neither .sdkrc nor .tool-versions found.'

  return 1
}

__use() {
  local file=$1
  local line

  while IFS= read -r line; do
    local candidate=${line%%[= ]*}
    local version=${line#*[= ]}

    if [[ ! -d "$SDKMAN_CANDIDATES_DIR/$candidate/$version" ]]; then
      __sdkman_install_candidate_version "$candidate" "$version"
    fi

    __sdk_use "$candidate" "$version"
  done < "$file"
}
