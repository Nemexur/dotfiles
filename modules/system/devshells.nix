{inputs, ...}: {
  perSystem = {
    lib,
    system,
    pkgs,
    ...
  }: let
    poetry1Deps = with pkgs; [uv (import inputs.nixpkgs-24-11 {inherit system;}).poetry];
    poetry2Deps = with pkgs; [uv poetry];
    pythonDevShells = builtins.listToAttrs (lib.lists.flatten (builtins.map (p: [
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
      ["python310" "python311" "python312"]));
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
        zig = pkgs.mkShell {
          name = "zig";
          packages = with pkgs; [zig];
        };
        rust = pkgs.mkShell {
          name = "rust";
          packages = with pkgs; [rustc cargo];
        };
      }
      // pythonDevShells;
  };
}
