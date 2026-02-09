#!/bin/sh
# Shell script run in CI to get Rust version on FreeBSD

set -e

# First, we check that this script is not run as root.
if [ "root" == "$(whoami)" ]; then exit 1; fi

echo "### OS infos"
uname -a

printf "\n"
echo "### Install Rust toolchain"
export CARGO_TERM_COLOR=always
curl https://sh.rustup.rs -sSf --output rustup.sh
sh rustup.sh -y --profile=minimal -t stable
. "${HOME}"/.cargo/env
rm rustup.sh

printf "\n"
echo "### Rust infos"
rustc -vV
printf "\n"
echo "### cargo infos"
cargo -vV

# Compare Rust versions
printf "\n"
echo "### Compare Rust versions"
REF_VERSION=$(grep -E "^rustc" freebsd_rust_version.txt | cut -d" " -f2)
RUST_VERSION=$(rustc -vV | grep -E "^rustc" | cut -d" " -f2)

echo "REF_VERSION = ${REF_VERSION}"
echo "RUST_VERSION = ${RUST_VERSION}"

if [ "$REF_VERSION" == "$RUST_VERSION" ]; then
	echo "SAME_VERSION=true" >> "$GITHUB_ENV"
else
	echo "SAME_VERSION=false" >> "$GITHUB_ENV"
	rustc -vV > freebsd_rust_version.txt
fi
echo "RUST_VERSION=${RUST_VERSION}" >> "$GITHUB_ENV"

