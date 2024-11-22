{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    devenv.shells.default = {
      devenv.root = let
        devenvRootFileContent = builtins.readFile inputs.devenv-root.outPath;
      in
        pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;

      name = "default";

      imports = [
        # This is just like the imports in devenv.nix.
        # See https://devenv.sh/guides/using-with-flake-parts/#import-a-devenv-module
        ./devenv-foo.nix
      ];

      packages = [
      ];
    };
  };
}
