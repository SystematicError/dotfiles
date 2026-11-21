{pkgs, ...}: {
  imports = [
    ./languages/nix.nix
  ];

  programs.zed-editor = {
    enable = true;

    package =
      if pkgs.stdenv.hostPlatform.isLinux
      then pkgs.zed-editor-fhs
      else pkgs.zed-editor;

    extraPackages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    extensions = ["vercel-theme" "charmed-icons"];

    userSettings = {
      format_on_save = "on";
      agent = {
        threads_sidebar.position = "right";
        dock = "right";
      };
      auto_signature_help = true;
      auto_update = false;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_line_height = "standard";
      code_lens = "on";
      collaboration_panel.button = false;
      diagnostics.inline.enabled = true;
      edit_predictions.allow_data_collection = "no";
      git.inline_blame.enabled = false;
      git_panel = {
        file_icons = true;
        tree_view = true;
      };
      icon_theme = "Base Charmed Icons";
      inlay_hints = {
        enabled = true;
        show_background = true;
      };
      languages.Nix.language_servers = [
        "nil"
        "!nixd"
      ];
      lsp.nil.initialization_options.formatting.command = [
        "alejandra"
        "--quiet"
        "--"
      ];
      markdown_preview.code_font_family = "JetBrainsMono Nerd Font";
      relative_line_numbers = "enabled";
      show_edit_predictions = false;
      sticky_scroll.enabled = true;
      tabs = {
        file_icons = true;
        git_status = true;
      };
      telemetry = {
        anthropic_retention = false;
        diagnostics = false;
        metrics = false;
      };
      terminal.show_count_badge = true;
      theme = {
        dark = "Vercel Dark";
        light = "Vercel Light";
        mode = "system";
      };
      title_bar = {
        show_branch_status_icon = true;
        show_onboarding_banner = false;
        show_sign_in = false;
      };
      toolbar.code_actions = true;
      use_smartcase_search = true;
      vim_mode = true;
      which_key.enabled = true;
    };
  };
}
