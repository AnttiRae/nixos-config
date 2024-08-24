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
	{
	  mode = "n";
	  key = "<leader>e";
	  options.silent = true;
	  action = "<cmd>CHADopen<CR>";
	}
        ];

        globals = {
            mapleader = " ";
        };

	plugins.lsp = {
	  enable = true;

	  servers = {
	    nixd = {
	      enable = true;
	    };
	    ruff-lsp = {
	      enable = true;
	    };
	    gopls= {
	      enable = true;
	    };
	  };

	};

	plugins.coq-nvim = {
	  enable = true;

	  settings = {
	    auto_start = true;
	  };
	};

	plugins.chadtree = {
	  enable = true;

	};
	plugins.telescope = {
	    enable = true;
	    settings = {

	    };
	    keymaps = {
		"<leader>ff" = {
		    action = "find_files";
		    options = {
			desc = "Find project files";
		    };
		};
		"<leader>fw" = {
		    action = "live_grep";
		    options = {
			desc = "Grep root dir";
		    };
		};
		"<leader>fb" = {
		    action = "buffers";
		    options = {
			desc = "Buffers";
		    };
		};
		"<leader>gc" = {
		    action = "git_commit";
		    options = {
			desc = "Search git commits";
		    };
		};
		"<leader>gf" = {
		    action = "git_files";
		    options = {
			desc = "Search git files";
		    };
		};
		"<leader>gs" = {
		    action = "git_status";
		    options = {
			desc = "Git status";
		    };
		};
		"<leader>fz" = {
		    action = "current_buffer_fuzzy_find";
		    options = {
			desc = "Search current buffer";
		    };
		};
	    };
	};
    };
}
