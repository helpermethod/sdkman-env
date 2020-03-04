#!/usr/bin/env bash

__sdk_env() {
  if [[ ! -f .tool-versions ]]; then
    __sdkman_echo_red '.tool-versions not found.'

    return 1
  fi

  local line

  while IFS= read -r line; do
    local candidate=${line%% *}
    local version=${line#* }

    [[ ! -d "$SDKMAN_CANDIDATES_DIR/$candidate/$version" ]] && sdk install "$candidate" "$version"
    sdk use "$candidate" "$version"
  done < .sdkrc
}
