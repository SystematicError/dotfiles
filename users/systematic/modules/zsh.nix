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
      cl = "clear";
      fexp = "xdg-open .";
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
