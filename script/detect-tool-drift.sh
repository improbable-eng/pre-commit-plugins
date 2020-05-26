#!/usr/bin/env bash
# shellcheck source=../lib/setup.sh
source "$(dirname "${BASH_SOURCE[0]}")/../lib/setup.sh" || exit "${EXIT_FAILED_TO_SOURCE}"

if is_person; then
  command -v goss >"/dev/null" || log_fatal "goss not found on PATH. Install it: \`imp-tool subscribe --tools goss\`"

  goss_file="workflow/pre-commit/tool-drift.goss.yaml"

  log_info "Checking your environment to see whether tools are installed at the versions we expect them to be..."
  log_info "If your environment has drifted, you will need to fix that by installing or linking the required versions of tools."
  log_info "Read ${goss_file} for those versions."

  goss --gossfile "${goss_file}" validate ||
    log_fatal "
    Inspect the above output to see how your workstation has drifted from what is meant to be present, and fix it, or you will be running differently than CI and will waste time debugging failures.

    Run \`./onboarding.sh\` and follow the prompts from the error messages.

    (If you have \`parallel\` via the \`moreutils\` package, uninstall \`moreutils\`. Its \`parallel\` is ancient and we need a 2020 version; refer to https://www.gnu.org/software/parallel)
    "
else
  log_success "If this is CI, we're using docker. We don't run all the same tools in every container (as that would be bad practice for containers)."
fi
