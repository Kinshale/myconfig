-- Detect when running inside VSCode
if not vim.g.vscode then
	return
end

vim.api.nvim_create_autocmd("textyankpost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
})

-- Set the map leader
vim.g.mapleader = " "

-- Keymaps (these call VS Code commands)
local opts = { noremap = true, silent = true }
local vscode = require("vscode")

-- HACK: 🧩 Enabling / navigating major panels
vim.keymap.set("n", "<leader>e", function() -- Explorer view
	vscode.call("workbench.view.explorer")
end, opts)

vim.keymap.set("n", "<leader>g", function() -- Git / Source Control view
	vscode.call("workbench.view.scm")
end, opts)

vim.keymap.set("n", "<leader>d", function() -- Debug view
	vscode.call("workbench.view.debug")
end, opts)

vim.keymap.set("n", "<leader>x", function() -- Extensions view
	vscode.call("workbench.view.extensions")
end, opts)

vim.keymap.set("n", "<leader>p", function() -- Command palette
	vscode.call("workbench.action.showCommands")
end, opts)

-- HACK: 🧭 Toggling stuff
vim.keymap.set("n", "<leader>tb", function() -- Toggle sidebar
	vscode.call("workbench.action.toggleSidebarVisibility")
end, opts)

vim.keymap.set("n", "<leader>tj", function() -- Toggle panel (terminal/output/debug)
	vscode.call("workbench.action.togglePanel")
end, opts)

vim.keymap.set("n", "<leader>tz", function() -- Toggle Zen mode
	vscode.call("workbench.action.toggleZenMode")
end, opts)

vim.keymap.set("n", "<leader>tn", function() -- Toggle minimap (added extra example)
	vscode.call("editor.action.toggleMinimap")
end, opts)

-- HACK: 🔍 Searching stuff
vim.keymap.set("n", "<leader>so", function() -- Search open files (Quick Open)
	vscode.call("workbench.action.quickOpen")
end, opts)

vim.keymap.set("n", "<leader>sg", function() -- Search by grep (global search)
	vscode.call("workbench.action.findInFiles")
end, opts)

vim.keymap.set("n", "<leader>ss", function() -- Search workspace symbols
	vscode.call("workbench.action.showAllSymbols")
end, opts)

-- HACK: 🛠️ Others
vim.keymap.set("n", "<leader>f", function() -- Format document
	vscode.call("editor.action.formatDocument")
end, opts)
