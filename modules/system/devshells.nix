{inputs, ...}: {
  perSystem = {
    lib,
    system,
    pkgs,
    ...
  }: let
    zigpkgs = inputs.zig.packages.${system};
    poetry1Deps = with pkgs; [uv (import inputs.nixpkgs-24-11 {inherit system;}).poetry];
    poetry2Deps = with pkgs; [uv poetry];
    pythonDevShells =
      ["python310" "python311" "python312" "python313" "python314"]
      |> map (p: [
        rec {
          name = p;
          value = pkgs.mkShell {
            inherit name;
            packages = with pkgs; [uv pkgs."${p}"];
          };
        }
        rec {
          name = "${p}-p1";
          value = pkgs.mkShell {
            inherit name;
            packages = poetry1Deps ++ [pkgs."${p}"];
          };
        }
        rec {
          name = "${p}-p2";
          value = pkgs.mkShell {
            inherit name;
            packages = poetry2Deps ++ [pkgs."${p}"];
          };
        }
      ])
      |> lib.lists.flatten
      |> builtins.listToAttrs;
  in {
    devShells =
      {
        go = pkgs.mkShell {
          name = "go";
          packages = with pkgs; [
            delve
            go
            gofumpt
            golangci-lint
            golines
            gotools
          ];
        };
        rust = pkgs.mkShell {
          name = "rust";
          packages = with pkgs; [rustc cargo];
        };
        tex = pkgs.mkShell {
          name = "latex";
          packages = with pkgs; [texliveFull];
        };
        odin = pkgs.mkShell {
          name = "odin";
          packages = with pkgs; [odin];
        };
        zig-latest = pkgs.mkShell {
          name = "zig-latest";
          packages = with zigpkgs; [default];
        };
        zig-nightly = pkgs.mkShell {
          name = "zig-nightly";
          packages = with zigpkgs; [master];
        };
      }
      // pythonDevShells;
  };
}
