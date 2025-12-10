{pkgs,...}:{
  programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [ "joshua" ];

    virtualisation.libvirtd.enable = true;
    virtualisation.libvirtd.qemu.swtpm.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    services.spice-vdagentd.enable = true;

virtualisation.podman = {
  enable = true;
  dockerCompat = true;
};
}