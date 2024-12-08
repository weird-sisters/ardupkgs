# `ardupkgs`

This project aims to make it easer to target [ArduPilot] project's different platforms. The initial goal is to structure all possible packaging of firmware as Nix packages and provide [Flake modules][flake-modules] for integration. It is a stand alone self-contained repository but for development setups it is expected to be used in conjunction with [`ardudev`], which is a [`devshell`] infrastructure that can be used to setup the required tooling and local enviroment shells in all supported systems, as well as seamlessly interfacing with `ardupkgs` itself.

[ArduPilot]: https://ardupilot.org/
[github-ardupilot]: https://github.com/ArduPilot/ardupilot
[`ardudev`]: https://github.com/weird-sisters/ardudev
[`devshell`]: https://numtide.github.io/devshell/
[flake-modules]: https://flake.parts/options/flake-parts-flakemodules#opt-flake.flakeModules
