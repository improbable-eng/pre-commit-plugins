#!/usr/bin/env bash
# shellcheck source=../lib/setup.sh
source "$(dirname "${BASH_SOURCE[0]}")/../lib/setup.sh" || exit "${EXIT_FAILED_TO_SOURCE}"

# skip bash stack-trace, otherwise our bash stack-traces clutter up the output.
export SKIP_BASH_STACKTRACE=1
for file_with_path in "$@"; do
  opa fmt --diff --write "${file_with_path}"
done
