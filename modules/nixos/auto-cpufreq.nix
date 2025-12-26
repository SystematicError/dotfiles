{...}: {
  services = {
    power-profiles-daemon.enable = false;

    auto-cpufreq = {
      enable = true;

      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };

        charger = {
          governor = "balanced";
          turbo = "auto";
        };
      };
    };
  };
}
