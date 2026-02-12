{
  description = "Home Manager configuration of aster";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-hazkey = {
      url = "github:aster-void/nix-hazkey";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";

  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-hazkey,
      nix-flatpak,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."aster" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          nix-hazkey.homeModules.hazkey
          ./home.nix
          ./modules/packages.nix
          ./modules/packages-desktop.nix
          ./modules/syncthing.nix
          ./modules/i18n.nix
          ./modules/ghostty.nix
        ];

        extraSpecialArgs = { inherit inputs; };
      };

      homeConfigurations."aster@bluebell" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          ./modules/packages.nix
        ];

        extraSpecialArgs = { inherit inputs; };
      };
    };
}
