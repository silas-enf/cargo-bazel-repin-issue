# Minimal cargo-bazel issue reproduction

This is a minimal repository exercising crate_universe, which can be used to
reproduce a caching issue related to it. `repro.sh` will run the necessary
commands to show the issue.

The issue seems to stem from some sort of caching of the `determine_repin` step
of crate_universe, preventing it from being run again in cases where it should
be. Since bazel doesn't run the check, the build does not fail and the
developer is free to continue working.

Eventually, one way or another, bazel decides to run `cargo-bazel` again and
notices the need for a repin, which means failures in CI in the good case and
failures for other users (possibly days after the PR is merged) in the bad one.
