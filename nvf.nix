{pkgs,lib,...}:{
vim = {
                options.shiftwidth = 2;
                options.tabstop = 2;
lsp.enable = true;
                lsp.formatOnSave = true;
autocomplete.nvim-cmp.enable = true;
autopairs.nvim-autopairs.enable = true;
languages.enableTreesitter = true;
languages.nix.enable = true;
statusline.lualine.enable = true;
theme.name = "tokyonight";
theme.style = "storm";
};
}
