{...}: {
  programs.eza = {
    enable = true;

    icons = "auto";
    extraOptions = ["--all"];
  };

  home.shellAliases = {
    ls = "eza";
    ll = "eza --long";
    lt = "eza --tree";
  };
}
