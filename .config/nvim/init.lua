-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo(
			{ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" }, { "\nPress any key to exit..." } },
			true,
			{}
		)
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
	spec = {
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000,
		},
		{
			{
				"nvim-lualine/lualine.nvim",
				dependencies = { "nvim-tree/nvim-web-devicons" },
			},
			{
				"nvimdev/dashboard-nvim",
				event = "VimEnter",
				config = function()
					require("dashboard").setup({
						config = {
							header = {
								" █████╗ ███╗   ██╗████████╗ ██████╗ ██╗███╗   ██╗███████╗██╗   ██╗██╗███╗   ███╗",
								"██╔══██╗████╗  ██║╚══██╔══╝██╔═══██╗██║████╗  ██║██╔════╝██║   ██║██║████╗ ████║",
								"███████║██╔██╗ ██║   ██║   ██║   ██║██║██╔██╗ ██║█████╗  ██║   ██║██║██╔████╔██║",
								"██╔══██║██║╚██╗██║   ██║   ██║   ██║██║██║╚██╗██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║",
								"██║  ██║██║ ╚████║   ██║   ╚██████╔╝██║██║ ╚████║███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║",
								"╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
							},
						},
					})
				end,
				dependencies = { { "nvim-tree/nvim-web-devicons" } },
			},
			{
				"nvim-telescope/telescope.nvim",
				tag = "0.1.8",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
			{
				"stevearc/conform.nvim",
				opts = {},
			},
			{ "nvim-treesitter/nvim-treesitter" },
			{
				"Bekaboo/dropbar.nvim",
				-- optional, but required for fuzzy finder support
				dependencies = {
					"nvim-telescope/telescope-fzf-native.nvim",
					build = 'make',
				},
			},
			{
				"akinsho/bufferline.nvim",
				version = "*",
				dependencies = "nvim-tree/nvim-web-devicons",
				after = "catppuccin",
			},
			{
				"windwp/nvim-autopairs",
				event = "InsertEnter",
				config = true,
				-- use opts = {} for passing setup options
				-- this is equivalent to setup({}) function
			},
			{ "neovim/nvim-lspconfig" },
			{ "nvim-tree/nvim-tree.lua" },
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = {
		colorscheme = { "catppuccin" },
	},
	-- automatically check for plugin updates
	checker = {
		enabled = true,
	},
})
--vim.opt.termguicolors = true
require("nvim-autopairs").setup()
require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	integrations = {
		dashboard = true,
	},
	--transparent_background = true, -- disables setting the background color.
	show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
	term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
})
require("lazy").setup({ { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" } })
require("bufferline").setup({
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
	options = {
		diagnostics = true,
	},
})
require("lualine").setup({
	options = {
		theme = "catppuccin",
		globalstatus = true,
	},
})
-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
require("nvim-tree").setup()
require("conform").setup({
	formatters = {
		clang_format = {
			command = "clang-format",
			args = { "--style=Google" }, -- Override to ensure Google style
			stdin = true,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "autopep8" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = {
			"rustfmt",
			lsp_format = "fallback",
		},
		-- Conform will run the first available formatter
		javascript = {
			"prettierd",
			"prettier",
			stop_after_first = true,
		},
		cpp = { "clang-format" },
		json = { "jq" },
	},
})
require("lspconfig").clangd.setup({})
-- mappings
local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", {
	desc = "move beginning of line",
})
map("i", "<C-e>", "<End>", {
	desc = "move end of line",
})
map("i", "<C-h>", "<Left>", {
	desc = "move left",
})
map("i", "<C-l>", "<Right>", {
	desc = "move right",
})
map("i", "<C-j>", "<Down>", {
	desc = "move down",
})
map("i", "<C-k>", "<Up>", {
	desc = "move up",
})

map("n", "<C-h>", "<C-w>h", {
	desc = "switch window left",
})
map("n", "<C-l>", "<C-w>l", {
	desc = "switch window right",
})
map("n", "<C-j>", "<C-w>j", {
	desc = "switch window down",
})
map("n", "<C-k>", "<C-w>k", {
	desc = "switch window up",
})

map("n", "<leader>n", "<cmd>set nu!<CR>", {
	desc = "toggle line number",
})
map("n", "<leader>rn", "<cmd>set rnu!<CR>", {
	desc = "toggle relative number",
})
map("n", "<C-s>", "<cmd>w<CR>", {
	desc = "general save file",
})
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require('conform').format()<CR>", {
	desc = "Format with Conform",
	noremap = true,
	silent = true,
})

map("n", "<leader>/", "gcc", {
	desc = "toggle comment",
	remap = true,
})
map("v", "<leader>/", "gc", {
	desc = "toggle comment",
	remap = true,
})

map("n", "<leader>q", "<cmd>q<CR>")

map("n", "<leader>v", "<cmd>vsplit<CR>")

map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", {
	desc = "nvimtree toggle window",
})
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", {
	desc = "nvimtree focus window",
})
vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>belowright 10split | wincmd j | terminal<CR>", {
	desc = "Open 10-line terminal below active window",
	noremap = true,
	silent = true,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		vim.opt_local.tabstop = 2 -- Number of spaces that a <Tab> counts for
		vim.opt_local.shiftwidth = 2 -- Number of spaces for indentation
		vim.opt_local.expandtab = true -- Use spaces instead of tabs
	end,
})
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "setlocal nobuflisted",
})
vim.wo.relativenumber = true
