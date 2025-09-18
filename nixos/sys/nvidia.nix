{pkgs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    package = pkgs.myLinux.nvidiaPackages.stable;
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    powerManagement.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [nvidia-vaapi-driver];
  };

  environment.variables = {
    WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "0";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";

    # Kill VRR/G-Sync at the driver level (common cause of jank)
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
  };

  environment.systemPackages = with pkgs; [
    pciutils
    mesa-demos
    vulkan-tools
  ];

  boot.blacklistedKernelModules = ["nouveau"];

  boot.kernelParams = ["nvidia-drm.modeset=1" "amd_pstate=active"];
  boot.kernelModules = ["nvidia-drm" "nvidia-uvm" "kvm-amd" "k10temp" "msr"];
}
