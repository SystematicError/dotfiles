{
  inputs,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [
      nix-inspect

      (writeShellScriptBin "nix-flake-use-system-nixpkgs" ''
        nix flake lock --override-input nixpkgs github:NixOS/nixpkgs/${inputs.nixpkgs.rev} "$@"
      '')

      (writeShellScriptBin "nix-flake-update-inputs-using-system-nixpkgs" ''
        nix flake update --override-input nixpkgs github:NixOS/nixpkgs/${inputs.nixpkgs.rev} "$@"
      '')
    ]
    ++ lib.optional stdenv.isLinux
    (pkgs.writeShellScriptBin "dementia" ''
      exec ${pkgs.bubblewrap}/bin/bwrap \
        --ro-bind / / \
        --dev-bind /dev /dev \
        --bind /proc /proc \
        --bind /sys /sys \
        --bind /run /run \
        --overlay-src /home --tmp-overlay /home \
        --overlay-src /tmp --tmp-overlay /tmp \
        -- \
        "''${@:-$SHELL}"
    '');

  programs.nh = {
    enable = true;

    flake = "/nixcfg";
    darwinFlake = "/Users/Shared/nixcfg";
  };
}
