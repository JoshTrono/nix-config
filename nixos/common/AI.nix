{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    loadModels = [
      "llama3.2"

    ];
  };
  services.open-webui = {
    package = pkgs.open-webui;
    enable = true;
    port = 3000;
  };
}
