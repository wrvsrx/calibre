{
  description = "flake template";

  inputs = {
    flake-lock.url = "github:wrvsrx/flake-lock";
    nixpkgs.follows = "flake-lock/nixpkgs";
    flake-parts.follows = "flake-lock/flake-parts";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } ({ inputs, ... }: {
    systems = [ "x86_64-linux" ];
    perSystem = { pkgs, ... }: rec {
      packages.default = pkgs.qt6Packages.callPackage ./default.nix { podofo = pkgs.podofo010; };
      devShells.default = pkgs.mkShell { inputsFrom = [ packages.default ]; };
      formatter = pkgs.nixpkgs-fmt;
    };
  });
}
