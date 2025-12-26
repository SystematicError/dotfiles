{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nix-inspect

    (writeShellScriptBin "dementia" ''
      exec ${bubblewrap}/bin/bwrap \
        --ro-bind / / \
        --dev-bind /dev /dev \
        --bind /proc /proc \
        --bind /sys /sys \
        --bind /run /run \
        --overlay-src /home --tmp-overlay /home \
        --overlay-src /tmp --tmp-overlay /tmp \
        -- \
        "''${@:-$SHELL}"
    '')

    (writeShellScriptBin "nix-flake-use-system-nixpkgs" ''
      nix flake lock --override-input nixpkgs github:NixOS/nixpkgs/${inputs.nixpkgs.rev} "$@"
    '')

    (writeShellScriptBin "nix-flake-update-inputs-using-system-nixpkgs" ''
      nix flake update --override-input nixpkgs github:NixOS/nixpkgs/${inputs.nixpkgs.rev} "$@"
    '')
  ];
}
