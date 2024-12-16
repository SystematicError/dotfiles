{pkgs, ...}: {
  home.packages = with pkgs; [
    planify
  ];

  dconf.settings."io/github/alainm23/planify" = {
    show-support-banner = true;
    clock-format = "12h";
    views-order-visible = ["inbox" "pinboard" "today" "scheduled" "completed" "labels"];
  };
}
