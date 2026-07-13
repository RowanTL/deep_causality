{
  description = "Rust env nix flake with Rust Rover";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
    lean4-nix.url = "github:lenianiva/lean4-nix";
  };

  outputs = {nixpkgs, rust-overlay, flake-utils, lean4-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) (lean4-nix.readToolchainFile ./lean/lean-toolchain) ];
        pkgs = import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };

        rustToolchain = 
          (pkgs.rust-bin.stable.latest.default.override {
            extensions = [ "rust-analyzer" "rust-src" ];
          });
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            rustToolchain
          ];

          buildInputs = with pkgs; [
            openssl
            pkg-config
            jetbrains.rust-rover
            curl

            # For lean verification
            lean.lean-all

            # cargo programs
            cargo-nextest
            cargo-outdated
            cargo-udeps
            cargo-audit
            cargo-machete

            # Needed for building the website
            nodejs

            # For AI agents and such
            openspec

            # Other build tools
            bazel-buildtools
          ];

          shellHook = ''
            mkdir -p ~/.rust-rover/toolchain

            ln -sfn ${rustToolchain}/lib ~/.rust-rover/toolchain
            ln -sfn ${rustToolchain}/bin ~/.rust-rover/toolchain

            export RUST_SRC_PATH="$HOME/.rust-rover/toolchain/lib/rustlib/src/rust/library"
          '';
        };
      }
    );
}

