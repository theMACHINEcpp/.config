-- General settings
vim.api.nvim_command(":set foldcolumn=1")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.colorcolumn= "80"
vim.opt.undofile = true
vim.opt.undodir ="/home/the-machine/Documents/undo/"
vim.opt.scrolloff = 8;




-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	
	{ 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
	"GustavoPrietoP/doom-themes.nvim",
	"LunarVim/bigfile.nvim",
	"JuliaEditorSupport/julia-vim",
	{ 'glacambre/firenvim', build = ":call firenvim#install(0)" },
	{ "karb94/neoscroll.nvim", config = function () require('neoscroll').setup({}) end},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl",  },
	"mbbill/undotree",
	"rafi/awesome-vim-colorschemes",
	"HampusHauffman/block.nvim",
	"anuvyklack/pretty-fold.nvim",
	"tpope/vim-surround",
	"tpope/vim-commentary",
	"neoclide/coc.nvim",
	"ryanoasis/vim-devicons",
	"preservim/tagbar",
	"terryma/vim-multiple-cursors",
	"nvim-telescope/telescope.nvim",
	"mikavilpas/yazi.nvim",
	"nvim-treesitter/nvim-treesitter",
})

--plugins.setup

require("ibl").setup()
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "cpp","python"},
	sync_install = true,
	auto_install = true,
	fold = {enable = true,},
	indent={enable=true,},
	highlight = {enable = true,additional_vim_regex_highlighting = false,},
}
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"




local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }



require('lualine').setup {
	  options = {
		icons_enabled = true,
		theme = 'ayu_dark',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
		  statusline = {},
		  winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
		  statusline = 100,
		  tabline = 100,
		  winbar = 100,
		}
	  },
	  sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	  },
	  inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	  },
	  tabline = {},
	  winbar = {},
	  inactive_winbar = {},
	  extensions = {}
}






-- Key mappings---------------------------------------------------------------------------------------------------
vim.api.nvim_set_keymap('n', '<leader>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><CR>", ":noh<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dd", ":call CocActionAsync('jumpDefinition')<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ee", ":CocDiagnostics<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>uu", ":UndotreeToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ft", ":TagbarToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ll", ":Lazy<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "<Tab>", "pumvisible() ? coc#_select_confirm() : \"<Tab>\"", { expr = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.api.nvim_set_keymap("n", "<leader>fy", ":Yazi toggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fr", ":Telescope registers<CR>", { noremap = true })

vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<S-C-h>', ':split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-C-l>', ':vsplit<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n',"<C-u>", "<C-u>zz", { noremap = true, silent = true });
vim.api.nvim_set_keymap('n',"<C-d>", "<C-d>zz", { noremap = true, silent = true });
vim.api.nvim_set_keymap('x', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q!<CR>', { noremap = true, silent = true })

--colorscheme-------------------------------------------------------------------------------------------------------
vim.cmd("colorscheme ayu")
vim.cmd('highlight SignColumn guibg=black')
vim.cmd('highlight CocErrorSign guifg=red')
vim.cmd('highlight CocWarningSign guifg=yellow')
vim.cmd('highlight CocErrorHighlight guifg=white guibg=red')
vim.cmd('highlight CocWarningHighlight guifg=yellow guibg=none')
vim.api.nvim_set_hl(0, "CocMenuSel", { bg = "#044a04", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "CocMenuNormal", { bg = "#044a04", fg = "#ffffff" })
vim.api.nvim_command("set background=dark")
vim.api.nvim_command("hi Normal ctermbg=0 guibg=#000000")
vim.api.nvim_command("hi LineNr ctermbg=0 ctermfg=3 guibg=#000000 guifg=#caa400")
vim.api.nvim_command("hi FoldColumn ctermbg=0 ctermfg=3 guibg=#000000 guifg=#caa400")
vim.cmd [[highlight Search  guifg=black guibg=orange]]
vim.cmd [[highlight IncSearch  guifg=white guibg=green]]
vim.cmd [[highlight Folded  guifg=#DFA54D guibg=#282828]]
