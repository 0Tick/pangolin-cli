# Pangolin CLI NixOS Module

A Nix flake providing a package and NixOS module for the [Pangolin CLI](https://github.com/fosrl/cli) VPN client.

## Quick Start

```bash
# Run directly
nix run github:your-user/pangolin-cli --impure

# Build
nix build github:your-user/pangolin-cli --impure
./result/bin/cli --help
```

## NixOS Configuration

Add to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    pangolin-cli.url = "github:your-user/pangolin-cli";
  };

  outputs = { nixpkgs, pangolin-cli, ... }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        pangolin-cli.nixosModules.pangolin-cli
        {
          nixpkgs.config.allowUnfree = true;
          programs.pangolin-cli.enable = true;
        }
      ];
    };
  };
}
```

## Home Manager

Add to your Home Manager `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    pangolin-cli.url = "github:your-user/pangolin-cli";
  };

  outputs = { nixpkgs, home-manager, pangolin-cli, ... }: {
    homeConfigurations."youruser" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        pangolin-cli.homeManagerModules.pangolin-cli
        {
          nixpkgs.config.allowUnfree = true;
          programs.pangolin-cli.enable = true;
        }
      ];
    };
  };
}
```

Or if Home Manager is used as a NixOS module, add it inside your home config:

```nix
{ inputs, ... }:
{
  imports = [ inputs.pangolin-cli.homeManagerModules.pangolin-cli ];
  programs.pangolin-cli.enable = true;
}
```

## Module Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `programs.pangolin-cli.enable` | boolean | `false` | Enable Pangolin CLI |
| `programs.pangolin-cli.package` | package | `pkgs.pangolin-cli` | Package to use |

## Flake Outputs

- `packages.<system>.pangolin-cli` — The CLI package
- `packages.<system>.default` — Alias for pangolin-cli
- `nixosModules.pangolin-cli` — NixOS module
- `nixosModules.default` — Alias for pangolin-cli module
- `homeManagerModules.pangolin-cli` — Home Manager module
- `homeManagerModules.default` — Alias for pangolin-cli HM module
- `overlays.default` — Nixpkgs overlay

## Using the Overlay

```nix
{
  nixpkgs.overlays = [ pangolin-cli.overlays.default ];
  environment.systemPackages = [ pkgs.pangolin-cli ];
}
```

## License

The Pangolin CLI itself has an unfree license. You must set `nixpkgs.config.allowUnfree = true` or use `--impure` flag.

