{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    (flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { system = system; };
        in
        {
          devShells = {
            default = pkgs.mkShell {
              packages = with pkgs; [
                gnumake
                texlive.combined.scheme-full
              ];
            };
          };
        }
      ));
}
