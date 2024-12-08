{ pkgs, lib, system, withSystem }:
let
  modules = [
    ./back-compat.nix
    ./ardutoolchain.nix
  ];

  pkgsModule =
    { ... }:
    {
      config = {
        _module.args.baseModules = modules;
        _module.args.pkgsPath = lib.mkDefault pkgs.path;
        _module.args.pkgs = lib.mkDefault pkgs;
        _module.args.system = lib.mkDefault system;
        _module.args.withSystem = lib.mkDefault withSystem;
      };
    };
in
[ pkgsModule ] ++ modules