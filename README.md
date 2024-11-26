# `ardupkgs`

This project aims to make it easer to target [ArduPilot] project's different platforms. The initial goal is to structure all possible packaging of firmware as Nix packages and provide Flake modules for integration. It's expected to be self-contained but the it is recommended for development to use it in conjunction with `ardudev`--which is a `devshell` infrastructure that can be used to setup the required tooling and local enviroment shells in all supported systems, as well as seamlessly interfacing with `ardupkgs`.

[ArduPilot]: https://ardupilot.org/
[github-ardupilot]: https://github.com/ArduPilot/ardupilot
[`ardudev`]: https://github.com/weird-sisters/ardudev
