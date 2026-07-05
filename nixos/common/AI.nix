{ pkgs, ... }:
{
  # services.ollama = {
  #   enable = true;
  #   package = pkgs.ollama-rocm;
  #   loadModels = [
  #     "llama3.2"

  #   ];
  # };
  # services.open-webui = {
  #   package = pkgs.open-webui;
  #   enable = true;
  #   port = 3000;
  # };

    hardware.amd-npu = {
    enable = true;
    enableNPU = true;         # default; set false for GPU-only hosts (see "Other hardware")
    enableFastFlowLM = true;  # LLM inference on NPU (requires enableNPU)
    enableLemonade = true;    # OpenAI-compatible API server
    enableROCm = true;        # ROCm GPU backends (llamacpp + sd-cpp)
    enableVulkan = true;      # Vulkan GPU backends (llamacpp + whispercpp)
    enableImageGen = true;    # default true; set false to drop sd-cpp from closure
    lemonade.user = "joshua";
  };

  users.users.joshua.extraGroups = ["video" "render"];
}
