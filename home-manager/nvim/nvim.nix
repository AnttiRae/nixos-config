{ config, pkgs, inputs, ... }: {
    imports = [ inputs.nixvim.homeManagerModules.nixvim ];

    programs.nixvim = {
        enable = true;
        defaultEditor = true;

        extraPlugins = with pkgs.vimPlugins; [
            gruvbox
        ];

        colorscheme = "gruvbox";
    
        opts = {
            number = true;
            relativenumber = true;

            shiftwidth = 2;
        };

        keymaps = [
        ];

        globals = {
            mapleader = " ";
        };
    };
}