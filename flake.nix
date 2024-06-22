{
  description = "cnnd's nixos config flake";

  inputs = {
    # might as well use the 24.05 version
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    # replace komodo with your hostname
    nixosConfigurations.komodo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix

        # add home-manager module
        # this makes home-manager deployment automatic
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # yet again, replace with your own info (unless you're also called cnnd... but that would be weird)
          home-manager.users.cnnd = import ./home.nix;
          # here we can use home-manager.extraSpecialArgs to pass arguments to home.nix, for example with spicetify
        }
      ];
    };
  };
}