{pkgs,...}:
{
services.ollama = {
  enable = true;
  package = pkgs.unstable.ollama-rocm;
  loadModels = [
    "qwen3:4b"
    
  ];
};
services.open-webui = {
  package = pkgs.unstable.open-webui;
  enable = true;
  port = 3000;
};
}