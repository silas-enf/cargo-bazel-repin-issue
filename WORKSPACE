workspace(
    name = "cargo-bazel-repin-issue",
)



load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "platforms",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/platforms/releases/download/0.0.6/platforms-0.0.6.tar.gz",
        "https://github.com/bazelbuild/platforms/releases/download/0.0.6/platforms-0.0.6.tar.gz",
    ],
    sha256 = "5308fc1d8865406a49427ba24a9ab53087f17f5266a7aabbfc28823f3916e1ca",
)

http_archive(
    name = "rules_rust",
    sha256 = "05e15e536cc1e5fd7b395d044fc2dabf73d2b27622fbc10504b7e48219bb09bc",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_rust/releases/download/0.8.1/rules_rust-v0.8.1.tar.gz",
        "https://github.com/bazelbuild/rules_rust/releases/download/0.8.1/rules_rust-v0.8.1.tar.gz",
    ],
)

RUST_VERSION = "1.65.0"

load(
    "@rules_rust//rust:repositories.bzl",
    "rules_rust_dependencies",
    "rust_register_toolchains",
    "rust_repository_set",
)

rules_rust_dependencies()

rust_repository_set(
    name = "rust_{}".format(RUST_VERSION),
    edition = "2021",
    exec_triple = "x86_64-unknown-linux-gnu",
    rustfmt_version = RUST_VERSION,
    version = RUST_VERSION,
)

rust_register_toolchains(
    edition = "2021",
    version = RUST_VERSION,
)

##### cargo workspace workflow for crate_universe
load("@rules_rust//crate_universe:defs.bzl", "crates_repository")

crates_repository(
    name = "crates",
    cargo_lockfile = "//:Cargo.lock",
    lockfile = "//:Cargo.Bazel.lock",
    manifests = [
        "//:Cargo.toml",
        "//rust/repro:Cargo.toml",
    ],
)

load("@crates//:defs.bzl", "crate_repositories")

crate_repositories()
