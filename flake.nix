{
  description = "Portable dev environment setup with Home Manager (impure user detection)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      # Pick the system you’re on now. If you move machines, change this or make Option B.
      system = "x86_64-linux";
    in {
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [
          # Impure: read USER/HOME from environment at switch time
          {
            home.username = builtins.getEnv "USER";
            home.homeDirectory = builtins.getEnv "HOME";
            home.stateVersion = "25.11";
            }
          ./home.nix
        ];
      };
    };
}

