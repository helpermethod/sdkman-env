#!/usr/bin/env bash

__sdk_env() {
  if [[ ! -f .sdkrc ]]; then
    __sdkman_echo_red '.sdkrc file not found.'

    return 1
  fi

  local line

  while IFS= read -r line; do
    local candidate=${line%=*}
    local version=${line#*=}

    [[ ! -d "$SDKMAN_CANDIDATES_DIR/$candidate/$version" ]] && sdk install "$candidate" "$version"
    sdk use "$candidate" "$version"
  done < .sdkrc
}
