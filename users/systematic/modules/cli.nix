{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs;
    [
      eza
      ripgrep
      yt-dlp
      curl
    ]
    ++ [
      inputs.frosty-vim.packages.x86_64-linux.default
    ];

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
  };

  programs = {
    zsh = {
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
        ip = "ip -c";

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

    starship = {
      enable = true;

      settings = {
        character = {
          success_symbol = "[➜](bold cyan)";
          error_symbol = "[➜](bold red)";
        };

        directory = {
          truncation_length = 3;
          style = "yellow bold";
        };

        cmd_duration = {
          min_time = 5000;
          style = "cyan bold";
        };

        nix_shell = {
          heuristic = true;
        };

        battery = {
          disabled = true;
        };
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
