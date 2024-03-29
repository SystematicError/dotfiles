{
  inputs,
  pkgs,
  ...
}: {
  home.username = "systematic";
  home.homeDirectory = "/home/systematic";

  home.packages = with pkgs; [
    ripgrep
    yt-dlp
    curl
    inputs.frosty-vim.packages.x86_64-linux.default

    obsidian
    gimp
    vesktop
    wireshark

    steam
    prismlauncher
    mgba
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"]; # TODO: Fix later idiot

  imports = [
    ./modules/desktop.nix
    ./modules/direnv.nix
    ./modules/easyeffects.nix
    ./modules/eza.nix
    ./modules/firefox.nix
    ./modules/git.nix
    ./modules/gnome.nix
    ./modules/hyprland.nix
    ./modules/spicetify.nix
    ./modules/starship.nix
    ./modules/wezterm.nix
    ./modules/zsh.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
