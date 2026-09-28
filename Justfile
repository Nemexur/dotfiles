# Run `nix-shell -p just`, then use `just` to list these recipes.
# Recipes use nh; `nix shell` supplies it during bootstrap if necessary.

set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

nh := "nix shell nixpkgs#nh --command nh"

# List available commands.
default:
    @just --list

# Evaluate this flake's checks.
check:
    nix flake check

# Format Nix files.
fmt:
    nix shell nixpkgs#nixfmt --command bash -c 'find . -name "*.nix" -not -path "./.git/*" -print0 | xargs -0 nixfmt'

# Update all flake inputs.
update:
    nix flake update

# Regenerate flake.nix from module-declared flake inputs.
write-flake:
    nix run .#write-flake

# Build a NixOS configuration without activating it.
build-nixos host="luffy":
    {{nh}} os build . --hostname {{host}}

# Build and activate a NixOS configuration.
switch-nixos host="luffy":
    {{nh}} os switch . --hostname {{host}}

# Build a nix-darwin configuration without activating it.
build-darwin host="zoro":
    {{nh}} darwin build . --hostname {{host}}

# Build and activate a nix-darwin configuration.
switch-darwin host="zoro":
    {{nh}} darwin switch . --hostname {{host}}

# Remove old Nix generations and unused store paths.
clean:
    {{nh}} clean all
