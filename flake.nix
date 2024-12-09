{
  description = "Building infrastructure for ArduPilot";

  nixConfig = {
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "tarc.cachix.org-1:wIYVNrWvfOFESyas4plhMmGv91TjiTBVWB0oqf1fHcE="
    ];
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
      "https://tarc.cachix.org"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs-darwin";
    };
  
    systems.url = "github:nix-systems/default";
    devshell.url = "github:numtide/devshell";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nixshellcmds.url = "github:weird-sisters/nixshellcmds";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      {
        flake-parts-lib,
        withSystem,
        ...
      }:
      let
        inherit (flake-parts-lib) importApply;
        flakeModules.default = importApply ./flake-module.nix {
          inherit inputs;
          inherit withSystem; 
        };
      in
      {
        imports = [
          flakeModules.default
          inputs.devshell.flakeModule
          inputs.nixshellcmds.flakeModules.flakeCmds
          inputs.nixshellcmds.flakeModules.shellInit
        ];
        systems = import inputs.systems;
        perSystem =
          {
            system,
            ...
          }:
          {
            _module.args.pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = [
                (final: prev: {
                  conan = inputs.nixpkgs-unstable.legacyPackages.${system}.conan;
                })
              ];
              config = { };
            };
            ardutoolchains.default = {
              # sitl by default
            };
            ardutoolchains.MatekH743 = {
              name = "MatekH743";
            };
          };
        flake = {
          inherit flakeModules;
        };
      }
    );
}
