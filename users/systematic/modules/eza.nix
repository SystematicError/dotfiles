{...}: {
  programs.eza = {
    enable = true;

    icons = true;
    extraOptions = ["--all"];
  };

  home.shellAliases = {
    ls = "eza";
    ll = "eza --long";
    lt = "eza --tree";
  };
}
