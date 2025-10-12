-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "[Q]uickfix" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "[Esc] terminal" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- s by default deletes a character and enters insert mode
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("x", "s", "<Nop>")

-- spell shortcuts
vim.keymap.set(
	"n",
	"<leader>tsi",
	"<cmd>set spell<cr><cmd>set spelllang=en_us,it<cr>",
	{ desc = "[t]oggle [s]pell [i]t & en_us" }
)
vim.keymap.set(
	"n",
	"<leader>tsu",
	"<cmd>set spell<cr><cmd>set spelllang=en_us<cr>",
	{ desc = "[t]oggle [s]pell en_[u]s" }
)
vim.keymap.set("n", "<leader>tsn", "<cmd>set nospell<cr>", { desc = "[t]oggle [s]pell [n]o" })
vim.keymap.set("i", "<c-s>", "<esc>[s1z=`]a", { desc = "[s]pell correct" }) -- Correct the previous mispelled word and returns in position
vim.keymap.set("n", "<c-s>", "1z=", { desc = "[s]pell correct" })
