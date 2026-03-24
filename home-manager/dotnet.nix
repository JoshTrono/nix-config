{ pkgs, config, ... }:

let
  dotnet-full =
    pkgs.dotnetCorePackages.combinePackages [
      pkgs.dotnetCorePackages.sdk_10_0
      pkgs.dotnetCorePackages.sdk_9_0
    ];
in
{
  home.packages = [
    dotnet-full
  ];

  home.sessionVariables = {
    DOTNET_ROOT = "${dotnet-full}/share/dotnet";
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "1";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.dotnet/tools"
  ];
}