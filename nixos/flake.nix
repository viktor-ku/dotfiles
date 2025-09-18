{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    swww.url = "github:LGFae/swww";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  # outputs = inputs @ {
  #   nixpkgs,
  #   home-manager,
  #   ...
  # }: {
  #   nixosConfigurations = {
  #     purrstation = nixpkgs.lib.nixosSystem {
  #       system = "x86_64-linux";
  #       specialArgs = {inherit inputs;};
  #       modules = [
  #         ({pkgs, ...}: {
  #           nixpkgs.overlays = [
  #             (import ./overlays/mylinux.nix)
  #             (import ./overlays/neovim.nix)
  #           ];
  #         })
  #
  #         ./sys/configuration.nix
  #
  #         ./sys/nvidia.nix
  #
  #         home-manager.nixosModules.home-manager
  #         {
  #           home-manager.useGlobalPkgs = true;
  #           home-manager.useUserPackages = true;
  #           home-manager.extraSpecialArgs = {inherit inputs;};
  #           home-manager.users.victoria = import ./home/home.nix;
  #         }
  #       ];
  #     };
  #   };
  # };
}
