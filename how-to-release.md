# How to: release

1. Update the changelog.
    * refer to <https://keepachangelog.com/en/1.0.0/>
1. Merge that.
1. Make an annotated git tag for the release following semver.
    * refer to <https://semver.org>
    * `git tag "${version}" -m "${version} ${some short message}"`
1. Push that.
    * `git push origin "${version}"`
1. Mention it internally on #eng-velocity with a link to the changelog.

You're done.
