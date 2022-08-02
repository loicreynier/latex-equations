{
  description = "LaTeX equations";

  inputs = {
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    mach-nix = {
      url = "github:DavHau/mach-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    mach-nix,
    pre-commit-hooks,
  }: (flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs {
      inherit system;
    };

    prettierWithTOML = pkgs.writeShellScriptBin "prettier" ''
      ${pkgs.nodePackages.prettier}/bin/prettier \
      --plugin-search-dir "${pkgs.nodePackages.prettier-plugin-toml}/lib" \
      "$@"
    '';

    pythonEnv = mach-nix.lib.${system}.mkPython {
      requirements = builtins.readFile ./requirements.txt;
    };
  in rec {
    checks = {
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = with pkgs; {
          make_readme = {
            enable = true;
            name = "make-readme";
            entry = "${pythonEnv}/bin/python docs/make_readme.py";
            files = "\\.(tex|yaml|py|md)";
            language = "system";
            pass_filenames = false;
          };

          alejandra.enable = true;
          black = {
            enable = true;
            entry = lib.mkForce "${pythonEnv}/bin/black";
            types = ["python"];
          };
          commitizen = {
            enable = true;
            entry = "${pythonEnv}/bin/cz check --commit-msg-file";
            stages = ["commit-msg"];
          };
          flake8 = {
            enable = true;
            entry = "${pythonEnv}/bin/flake8";
            types = ["python"];
          };
          pylint = {
            enable = true;
            entry = "${pythonEnv}/bin/pylint -rn -sn";
            types = ["python"];
          };
          isort = {
            enable = true;
            entry = lib.mkForce "${pythonEnv}/bin/isort";
            types_or = ["pyi" "python"];
          };

          editorconfig-checker = {
            enable = true;
            entry = "${pkgs.editorconfig-checker}/bin/editorconfig-checker";
            types = ["file"];
          };
          prettier = {
            enable = true;
            entry = lib.mkForce "${prettierWithTOML}/bin/prettier --check";
            types_or = ["markdown" "toml" "yaml"];
          };
          statix.enable = true;
        };
      };
    };

    devShells = {
      default = pkgs.mkShell {
        packages = with pkgs; [
          just
          pandoc
          prettierWithTOML
          pythonEnv
          texlive.combined.scheme-full
        ];
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    };
  }));
}
