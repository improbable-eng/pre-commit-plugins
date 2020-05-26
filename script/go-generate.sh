#!/usr/bin/env bash
# shellcheck source=../lib/setup.sh
source "$(dirname "${BASH_SOURCE[0]}")/../lib/setup.sh" || exit "${EXIT_FAILED_TO_SOURCE}"
# It's legitimate for a linter to exit non-zero; some indicate success-but-lint that way.
set +o errexit

# skip bash stack-trace, otherwise our bash stack-traces clutter up the output.
export SKIP_BASH_STACKTRACE=1

ensure_go_tool_dependency "mockery" "github.com/vektra/mockery/cmd/mockery"

log_info "Checking 'go:generate' directives..."
go generate ./...

if ! git diff --exit-code -- "**/mocks"; then
  log_fatal "Diffs found. To fix, run 'go generate ./...' and commit."
fi
