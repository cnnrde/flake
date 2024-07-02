{
  description = "cnnd's nixos config flake";

  inputs = {
    # might as well use the 24.05 version
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # add spicetify
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, ... }: {
    # replace komodo with your hostname
    nixosConfigurations.komodo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos/configuration.nix
        # add home-manager module
        # this makes home-manager deployment automatic
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # yet again, replace with your own info (unless you're also called cnnd... but that would be weird)
          home-manager.users.cnnd = import ./home-manager/home.nix;
          # here we can use home-manager.extraSpecialArgs to pass arguments to home.nix, for example with spicetify
          home-manager.extraSpecialArgs = {
            inherit spicetify-nix;
          };
        }
      ];
    };
  };
}
