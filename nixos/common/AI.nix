{pkgs,...}:
{
services.ollama = {
  enable = true;
  package = pkgs.ollama-rocm;
  loadModels = [
    "gemma3"
    
  ];
};
services.open-webui = {
  package = pkgs.open-webui;
  enable = true;
  port = 3000;
};
}