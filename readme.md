# pre-commit-plugins

> Welcome to our [`pre-commit`] plugins repository. There are many like it (<https://pre-commit.com/hooks.html>), but this one is ours. Automation is our best friend, it is our life. We must master is as we must master our lives. Without me, our automation continues to work in CI. Without our automation, we must manually test things. We must run our automation true. We must ship software faster than our competitors, who are trying to ... compete. We will. Before God we swear this creed: our automation and ourselves are defenders of the integrity of our products, we are the masters of our software codes, we are the saviors of shipping fast and iterating with confidence. So be it, until there is no competition, but peace. Amen.

(With thanks to _Full Metal Jacket_)

## Why do you want this?

We use [`pre-commit`] to

* automate formatting
  * ... since that saves time and inconsistency within code-review.
* lint as much as we can
  * ... because automating style-guides is more productive than memorising them and talking about them in code-review.
* run such checks in a consistent way on developer workstations
  * ... because reducing cycle-time (engineers cost a lot!) and saving CI costs (so do computers!) and are both really beneficial.

## Using and maintaining pre-commit within improbable

See [`pre-commit`] upstream documentation.

It's a framework for running checks against files so that things like lint and formatting are locally enforced, to avoid burning code-review time and CI spend.

### Local workflow how-tos

#### How to: get set up

Use `{our internal platform repo's}/tools/environment/python/bootstrap.sh` script. We rely on specifics of what that does, please use that rather than DIY.

Then, in this repo:

```shell
pip install -r requirements.txt
```

That gives you a system-level `pre-commit` that will work.

The gold standard is to combine `direnv` and a `.envrc` files to give you a python virtualenv unique to a repository when you `cd` into it. See `{our internal platform repo's}/tools/environment/python/envrc.sh` and `{our internal platform repo's}/.envrc` for inspiration.

#### How to: make all git repos you clone automatically have `pre-commit` wired if they contain config

See [upstream's "automatically enabling pre-commit on repositories"].

#### How to: bypass git pre-push or commit checks

Use the `--no-verify` flag of the `git push` (or `commit`) command to skip enforced checks for one execution. e.g. `git push --no-verify`. This allows you to push a branch with linting errors.

See [pre-commit's docs](https://pre-commit.com/#temporarily-disabling-hooks) for more information.

#### How to: run pre-commit checks without committing

Run `pre-commit run` to execute all the pre-commit hooks against the staged files. Add the `--all-files` option to run it also on not-staged files (useful for example if you have previously committed/pushed with linting errors using the `--no-verify` option).

See [pre-commit docs](https://pre-commit.com/#pre-commit-run) for more information.

#### How to: update plugins

See [upstream's `pre-commit autoupdate`] section.

#### How to: add new plugins

What makes a good pre-commit plugin?

* Something that runs _fast_. We do not want to be a burden on the local iteration workflow.
  * For `pre-commit`, something less than ~2s.
  * For `pre-push`, something less than ~30s.
* Something that does not depend on something else's output.
  * ... because workflow dependencies in shell scripts are brittle to maintain and extend. Don't do it.

##### How to: add a new plugin that exists already on the internet

Add the configuration into `.pre-commit.config.yaml`. See [upstream's Adding pre-commit plugins to your project].

##### How to: add a new plugin from scratch

See [upstream's `Creating new hooks`], especially the [`pre-commit try-repo` iteration workflow].

See also the `scripts` directory of this repository for simple examples.

##### How to: add an in-repo plugin

See <https://pre-commit.com/#repository-local-hooks> - these are useful to iterate on something before offering it here.

For extra credit, make them emit TAP/junit/checkstyle to be scraped during CI to the results annotation.

**Note:** hopefully, your in-repo plugin will be shared back here for other people to benefit!

[`pre-commit`]: https://pre-commit.com
[upstream's Adding pre-commit plugins to your project]: https://pre-commit.com/#plugins
[upstream's `Creating new hooks`]: https://pre-commit.com/#new-hooks
[`pre-commit try-repo` iteration workflow]: https://pre-commit.com/#developing-hooks-interactively
[upstream's `pre-commit autoupdate`]: https://pre-commit.com/#pre-commit-autoupdate
[upstream's "automatically enabling pre-commit on repositories"]: https://pre-commit.com/#automatically-enabling-pre-commit-on-repositories
