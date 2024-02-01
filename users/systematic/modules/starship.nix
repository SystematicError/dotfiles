{...}: {
  programs.starship = {
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
}
