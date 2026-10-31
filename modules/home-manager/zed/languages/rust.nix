{pkgs, ...}: {
  home.packages = with pkgs; [
    rust-analyzer
  ];

  programs.zed-editor = {
    userSettings = {
      "lsp" = {
        "rust-analyzer" = {
          "initialization_options" = {
            check.command = "clippy";
          };
        };
      };
    };
  };
}
