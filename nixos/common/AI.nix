{pkgs,...}:
{
services.ollama = {
  enable = true;
  acceleration = "rocm";
};
services.open-webui = {
  enable = true;
  port = 3000;
};
}