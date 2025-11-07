-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "[Esc] terminal" })

-- CHAPTER: Window management

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window right" })

-- Tab management
vim.keymap.set("n", "<C-w>t", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<C-w>q", "<cmd>tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<C-w>o", "<cmd>tabonly<CR>", { desc = "Only tab (close others)" })

vim.keymap.set("n", "<C-w>n", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<C-w>p", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- Window management
vim.keymap.set("n", "<C-w>|", "<cmd>vsplit<CR>", { desc = "Split Vertically" })
vim.keymap.set("n", "<C-w>-", "<cmd>split<CR>", { desc = "Split Horizontally" })
vim.keymap.set("n", "<C-w>w", "<cmd>close<CR>", { desc = "Close Window" })

-- CHAPTER: Spelling
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
