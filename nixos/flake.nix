{
  description = "NixOS Setup";

	inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
	inputs.home-manager = {
		url = "github:nix-community/home-manager/release-25.11";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  inputs.nix4nvchad = {
    url = "github:nix-community/nix4nvchad";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs { inherit system; };
      extraSpecialArgs = { inherit system inputs; };
      specialArgs = { inherit system inputs; };
  in { 
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit system inputs; 
      };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = {
              inherit system inputs; 
            };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.noahsakko = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        dotnet-sdk_10
        fontconfig.lib
        freetype
        expat
      ];
      shellHook = ''
        export DOTNET_ROOT=${pkgs.dotnet-sdk_10}
        export LD_LIBRARY_PATH="$(pwd)/bin/Debug/net10.0/runtimes/linux-x64/native:$LD_LIBRARY_PATH"
  export FONTCONFIG_PATH="${pkgs.fontconfig}/etc/fonts"
      '';
    };
  };
}
