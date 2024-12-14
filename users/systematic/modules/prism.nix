{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    prismlauncher
  ];

  home.file.prism-mellow-theme = {
    source = "${inputs.prism-themes}/themes/Mellow";
    target = ".local/share/PrismLauncher/themes/Mellow";
  };
}
