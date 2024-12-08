{
  inputs,
  withSystem,
  ...
}:
{ lib, flake-parts-lib, ... }:
let
  inherit (flake-parts-lib) mkPerSystemOption;
  inherit (lib) mkAliasDefinitions mkOption types;
in
{
  options = {
    perSystem = mkPerSystemOption (
      { config, pkgs, system, options, ... }:
      {
        options.ardutoolchains = mkOption {
          description = ''
            Setup ArduPilot toolchains with flake-parts.
          '';

          type = types.lazyAttrsOf (
            types.submoduleWith { modules = import ./modules/modules.nix { inherit pkgs lib withSystem system; }; }
          );

          default = { };
        };

        config = {
          packages = lib.mapAttrs (_name: ardutoolchain: pkgs.hello) config.ardutoolchains;
        };
      }
    );
  };
}
