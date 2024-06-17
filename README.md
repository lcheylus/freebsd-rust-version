# freebsd-rust-version

GitHub workflow to get the latest Rust version on FreeBSD

## Details

This GitHub workflow runs automatically via scheduling (twice a day). It checks
the latest Rust version on FreeBSD stable and commits it in a text file if
needed.

- Run a FreeBSD VM via `[vmactions/freebsd-vm](https://github.com/vmactions/freebsd-vm)` action.
- On FreeBSD, install the latest Rust stable version with `rustup`.
- Compare the current Rust version with ref. version.
- If the Rust version changed, automatic commit of `rustc -vV` output in
  `freebsd_rust_version.txt` file with `[EndBug/add-and-commit](https://github.com/EndBug/add-and-commit)` action.
