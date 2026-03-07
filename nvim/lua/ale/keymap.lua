-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "[Esc] terminal" })

-- CHAPTER: Copying and pasting

-- '"+' is synchronized with system clipboard,
-- '""' is the last deleted / yanked / changed text.

-- C-v vor pasting
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "[D]elete no yank" })
vim.keymap.set({ "n", "v" }, "<C-v>", '"+p')
vim.keymap.set("i", "<C-v>", '<Esc>"+pa')

-- Move block-visual mode from <C-v> to <A-v>
vim.keymap.set("n", "<A-v>", "<C-v>")
vim.keymap.set("v", "<A-v>", "<C-v>")

-- CHAPTER: Spelling
-- s by default deletes a character and enters insert mode
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("x", "s", "<Nop>")

-- TODO: Improve this. Doesn't work fluidly.
vim.keymap.set("n", "<C-s>", "<Nop>")
vim.keymap.set("n", "<C-s>l", "]s1z=", { desc = "[S]pell correct right" })
vim.keymap.set("n", "<C-s>h", "[s1z=", { desc = "[S]pell correct left" })
vim.keymap.set("i", "<C-s>", "<esc>[s1z=`]a", { desc = "[S]pell correct" })

-- Toggling spell shortcuts
vim.keymap.set("n", "<leader>tsi", "<cmd>set spell<cr><cmd>set spelllang=en_us,it<cr>", { desc = "[i]t & en_us" })
vim.keymap.set("n", "<leader>tsu", "<cmd>set spell<cr><cmd>set spelllang=en_us<cr>", { desc = "en_[u]s" })
vim.keymap.set("n", "<leader>tsn", "<cmd>set nospell<cr>", { desc = "[n]o" })

-- CHAPTER: Toggling
vim.keymap.set("n", "<leader>tn", function()
	vim.o.number = not vim.o.number
	vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Line [N]umbers" })

-- CHAPTER: Window and tab management
-- Window management
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window right" })

vim.keymap.set("n", "<C-w>v", "<cmd>vsplit<CR>", { desc = "Split Vertically" })
vim.keymap.set("n", "<C-w>s", "<cmd>split<CR>", { desc = "Split Horizontally" })
vim.keymap.set("n", "<C-w>w", "<cmd>close<CR>", { desc = "Close Window" })

-- Tab management
vim.keymap.set("n", "<C-t>", "<Nop>")
vim.keymap.set("n", "<C-q>", "<Nop>")
vim.keymap.set("n", "<C-t>", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<C-q>", "<cmd>tabclose<CR>", { desc = "Close tab" })

-- TODO: Ctrl + A for selecting everything

-- CHAPTER: Plugin / info
vim.keymap.set("n", "<leader>,p", "<cmd>Lazy<CR>", { desc = "[P]lugin manager (Lazy)" })
vim.keymap.set("n", "<leader>,f", "<cmd>ConformInfo<CR>", { desc = "[F]ormatter Info (Conform)" })
vim.keymap.set("n", "<leader>,li", "<cmd>LspInfo<CR>", { desc = "[L]sp [I]nfo" })
vim.keymap.set("n", "<leader>,m", "<cmd>Mason<CR>", { desc = "[M]ason (LSP/DAP/Linter Manager)" })
vim.keymap.set("n", "<leader>,t", "<cmd>TSInstallInfo<CR>", { desc = "[T]reesitter Info" })
vim.keymap.set("n", "<leader>,c", "<cmd>checkhealth<CR>", { desc = "[C]heckhealth (Diagnostics)" })
