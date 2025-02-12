-- [[ Setting options ]]
-- See `:help vim.o`

-- Don't wrap lines
vim.wo.wrap = false

-- Make line numbers relative
vim.wo.number = true
vim.wo.relativenumber = true

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

-- keep cursor in the middle of the screen
vim.o.scrolloff = 15

-- Line numbers should take minimum space
vim.o.nuw = 1

-- Update diagnoctics in insert mode
vim.diagnostic.config({ update_in_insert = true, source = true, signs = false })

-- no '~' on blank lines
vim.opt.fillchars = { eob = ' ' }

-- highlight current line
vim.opt.cursorline = true

-- tab width
vim.opt.tabstop = 2

-- add cmd to copy file path
vim.cmd("command! CopyRelPath call setreg('+', expand('%'))")

-- split to the right
vim.opt.splitright = true

-- split below
vim.opt.splitbelow = true

-- change fill chars for diffview
vim.opt.fillchars:append({ diff = '╱' })

-- firenvim config
vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*"] = {
      cmdline  = "neovim",
      content  = "text",
      priority = 0,
      selector = "textarea",
      takeover = "never"
    }
  }
}
