#!/usr/bin/env bash
# shellcheck source=../lib/setup.sh
source "$(dirname "${BASH_SOURCE[0]}")/../lib/setup.sh" || exit "${EXIT_FAILED_TO_SOURCE}"
# It's legitimate for a linter to exit non-zero; some indicate success-but-lint that way.
set +o errexit

# skip bash stack-trace, otherwise our bash stack-traces clutter up the output.
export SKIP_BASH_STACKTRACE=1

ensure_go_tool_dependency "goimports" "golang.org/x/tools/cmd/goimports"

for file_with_path in "${@}"; do
  log_debug "goimports -w '${file_with_path}'..."
  goimports -w "${file_with_path}"
done
