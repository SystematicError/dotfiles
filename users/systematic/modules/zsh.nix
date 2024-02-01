{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";
    enableVteIntegration = true;

    history = {
      save = 2000;
      size = 2000;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };

    shellAliases = {
      sudo = "sudo ";

      git = "TZ=UTC git";
      grep = "grep -i";
      rg = "rg -S";

      cl = "clear";
      nv = "nvim";

      ls = "eza -A --icons";
      ll = "eza -Al --icons";
      lt = "eza -AT --icons";
    };

    plugins = with pkgs; [
      {
        name = "autopair";
        src = zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }

      {
        name = "autosuggestions";
        src = zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }

      {
        name = "syntax-highlighting";
        src = zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
    ];
  };
}
