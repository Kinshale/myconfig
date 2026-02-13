vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable true color support
-- vim.opt.termguicolors = true

--  See `:help 'clipboard'`
-- vim.schedule(function()
-- 	vim.opt.clipboard = "unnamedplus"
-- end)

-- Number of spaces for indentation
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false

vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true

vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true

--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", extends = "→", precedes = "←" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.spell = false
vim.keymap.set(
	"n",
	"<leader>ti",
	"<cmd>set spell<cr><cmd>set spelllang=en_us,it<cr>",
	{ desc = "[t]oggle spell [i]t & en_us" }
)
vim.keymap.set("n", "<leader>tu", "<cmd>set spell<cr><cmd>set spelllang=en_us<cr>", { desc = "[t]oggle spell en_[u]s" })
vim.keymap.set("n", "<leader>tn", "<cmd>set nospell<cr>", { desc = "[t]oggle [n]o spell" })
vim.opt.spelllang = "en_gb"
vim.keymap.set("i", "<c-s>", "<esc>[s1z=`]a", { desc = "[s]pell correct" })
vim.keymap.set("n", "<c-s>", "[s1z=", { desc = "[s]pell correct" })
