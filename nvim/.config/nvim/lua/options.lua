local opt = vim.opt

opt.autoindent = true -- autoindent when creating new lines
opt.autoread = true -- automatically re-read an open file if it has been changed externally
opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus' -- Sync with system clipboard
opt.colorcolumn = '100' -- Set a vertical line at 100 chars
opt.completeopt = 'menu,menuone,noselect' -- Use a popup menu to show possible selections, don't preselect
opt.conceallevel = 0 -- Show all text normally
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.equalalways = false -- Don't resize windows to be equal after one is closed
opt.expandtab = true -- Use spaces instead of tabs
opt.fillchars = { -- characters to fill the statusline, vertical separators and special lines
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

opt.foldlevel = 99 -- Effectively disables folding sections by default
opt.foldcolumn = '0'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- use treesitter to define fold points
opt.foldmethod = 'expr' -- use expresion for folding, see below
opt.foldnestmax = 1
function _G.MyFoldText()
  return vim.fn.getline(vim.v.foldstart)
end
vim.opt.foldtext = 'v:lua.MyFoldText()'

opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = '%f:%l:%c:%m' -- allows parsing the grep command output
opt.grepprg = 'rg --vimgrep' -- Use ripgrep for grepping
opt.ignorecase = true -- Ignore case, see also smartcase
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.jumpoptions = 'view' -- Try to preserve the screen position when jumping through lists (e.g. using C-o)
opt.laststatus = 3 -- Always have a single statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.ruler = false -- Disable the default ruler
opt.scrolloff = 12 -- Lines of context
opt.sessionoptions = 'buffers,curdir,folds,globals,help,skiprtp,tabpages,terminal,winsize' --Aspects of a session to restore
opt.shiftround = true -- Round indent to multiple of shiftwidth
opt.shiftwidth = 4 -- Size of an indent
opt.shortmess:append { W = true, I = true, c = true, C = true } -- Configure short message
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 6 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case when capitals present.
opt.smartindent = true -- Insert indents automatically
opt.smoothscroll = true -- Try to scroll smoothly rather than line by line
opt.softtabstop = 4 -- Soft tab to enter spaces for tabs as appropriate
opt.spelllang = { 'en' } -- Spelling language
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = 'screen' -- Keep the text on the same screen line when splitting
opt.splitright = true -- Put new windows right of current
-- opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.tabstop = 4 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.undofile = true -- Save undo history
opt.undolevels = 10000 -- Save lots of history
opt.updatetime = 50 -- Save swap file and trigger CursorHold
opt.virtualedit = 'none' -- Don't allow virtual editing, even when the global value is used
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
