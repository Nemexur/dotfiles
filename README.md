# Dotfiles

Personal Nix flake for NixOS and macOS. It replaces the repository's former
Ansible-based setup with composable NixOS, nix-darwin, and Home Manager modules.

> This is a personal configuration, not a generic installer. It contains
> host-specific hardware settings, user names, and encrypted secrets. Read and
> adapt the relevant host and user modules before applying it on another machine.

## Hosts

| Host           | Platform      | Configuration           |
| -------------- | ------------- | ----------------------- |
| `luffy`        | x86_64 Linux  | NixOS desktop/laptop    |
| `zoro`         | Apple Silicon | nix-darwin              |
| `work-macbook` | Apple Silicon | nix-darwin work machine |

## Layout

- `flake.nix` — flake inputs and the top-level module importer. Generated with
  [`flake-file`](https://github.com/vic/flake-file); change the declarations in
  `modules/` and regenerate it rather than editing it directly.
- `modules/hosts/` — per-host configuration, hardware, users, and secrets.
- `modules/system/` — shared OS and system settings.
- `modules/programs/` — shared applications and Home Manager programs.
- `modules/services/` — shared service configuration.
- `modules/users/` — reusable user definitions.
- `secrets/` — public age identity and encrypted, host-specific secret material.
- `packages/` — local package sources.

## Prerequisites

Install [Nix](https://nixos.org/download/) yourself, with flakes enabled. The
commands below use [`just`](https://github.com/casey/just) as a small command
runner and [`nh`](https://github.com/viperML/nh) for NixOS and nix-darwin
operations.

This configuration installs `just` and `nh` after it has been activated. Until
then, enter a temporary shell containing `just`:

```sh
nix-shell -p just
```

The Justfile obtains `nh` through `nix shell` when it is not already available,
so no separate bootstrap package is required.

## Install or apply

1. Clone this repository to the location expected by the configuration:

   ```sh
   git clone https://github.com/Nemexur/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Start the temporary `just` shell shown above.

3. Inspect available commands, then build or activate the configuration for the
   current machine:

   ```sh
   just
   just build-nixos luffy
   just switch-nixos luffy
   ```

   On macOS, use the Darwin recipes instead:

   ```sh
   just build-darwin zoro
   just switch-darwin zoro
   ```

   The `switch-*` recipes use `nh`, which handles elevation when activation
   requires it. Review the diff and any secret prerequisites before confirming.

## Register a new host

1. Add the host and user public SSH keys to the appropriate `age.rekey`
   configuration (and keep the corresponding private identity available on the
   machine, normally at `~/.ssh/agenix`).
2. Run `agenix-rekey` to create or refresh the host's rekeyed secret files.
3. Create `modules/hosts/<host>/` with the host configuration, user module, age
   configuration, and `flake-parts.nix` that exposes the NixOS or nix-darwin
   configuration.
4. Build and activate it with the matching `just build-* <host>` and
   `just switch-* <host>` commands; fix evaluation, build, and activation issues
   as they appear.
5. Add the gopass repository that provides the host's secret material.

Do not copy another host's encrypted secrets or private keys.

## Daily use

```sh
just                 # list recipes
just check           # evaluate flake checks
just fmt             # format Nix files
just update          # update flake inputs
just clean           # clean old Nix generations via nh
```

Use `just build-nixos <host>` or `just build-darwin <host>` before a switch when
you only want to validate a change. Pass any extra Nix build options after `--`,
for example:

```sh
just build-nixos luffy -- --show-trace
```

## Secrets

Secrets are managed with `agenix` and `agenix-rekey`; activation expects the
appropriate age identity (normally `~/.ssh/agenix`) and the host's rekeyed
secret files. They are deliberately not documented as a one-size-fits-all
bootstrap procedure. Do not copy another host's encrypted secrets or private
keys.
