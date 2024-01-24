-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
-- vim.wo.relativenumber = true

-- insert mode block cursor
-- vim.opt.guicursor = ''

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Hide command line when not in use
vim.o.cmdheight = 0

-- keep cursor in the middle of the screen
vim.o.scrolloff = 10

-- Line numbers should take minimum space
vim.o.nuw = 1

-- Update diagnoctics in insert mode
vim.diagnostic.config { update_in_insert = true }

-- no '~' on blank lines
vim.opt.fillchars = { eob = " " }




-- local keys = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     -- require("telescope.builtin").find_files()
--     vim.api.nvim_feedkeys(keys, 'm', false)
--     vim.cmd('NvimTreeOpen')
--   end,
-- })
