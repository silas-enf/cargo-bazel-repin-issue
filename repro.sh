#!/bin/sh

check_repin() {
    external=$1;
    debug_run $external/crates/cargo-bazel query \
        --lockfile Cargo.Bazel.lock \
        --config $external/crates/cargo-bazel.json \
        --splicing-manifest $external/crates/splicing_manifest.json \
        --cargo $external/rust_linux_x86_64__x86_64-unknown-linux-gnu_tools/bin/cargo \
        --rustc $external/rust_linux_x86_64__x86_64-unknown-linux-gnu_tools/bin/rustc
}

info() {
    echo ">>>"
    echo ">>> $*"
    echo ">>>"
    sleep 1
}

debug_run() {
    echo "\$ $@"
    "$@"
}

tmp=$(mktemp -d)
flags="--repository_cache $tmp/repository_cache --disk_cache $tmp/disk_cache"
rm -f rust/repro/tests/x.rs

info "initial build -- there should be no need to repin"
debug_run bazel build $flags //rust/repro:all

info "run cargo-bazel manually to show that no repin is needed (no \"repin\" on stdout)"
external=$(bazel info $flags output_base)/external
check_repin $external

info "create a .rs file under tests/"
debug_run touch rust/repro/tests/x.rs

info "now cargo-bazel says it needs a repin (should be a hash mismatch in the output)"
check_repin $external

info "but bazel continues on its merry way"
debug_run bazel build $flags //rust/repro:all

