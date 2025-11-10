local function toggle_conceallevel()
	if vim.wo.conceallevel == 0 then
		vim.wo.conceallevel = 2
	else
		vim.wo.conceallevel = 0
	end
end

---@diagnostic disable: missing-fields
vim.keymap.set("n", "<leader>lc", "<cmd>w<CR><cmd>VimtexCompile<CR>", { desc = "VimTex [C]ompile" })
vim.keymap.set("v", "<leader>lc", "<cmd>VimtexCompileSelected<CR><CR>", { desc = "VimTex [C]ompile" })
vim.keymap.set("n", "<leader>lC", "<cmd>VimtexClean<CR>", { desc = "VimTex [C]lean", buffer = true })
vim.keymap.set("n", "<leader>ls", "<cmd>VimtexStop<CR>", { desc = "VimTex Compile [S]top" })
vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>", { desc = "VimTex [E]rrors" })
vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "VimTex [V]iew" })
vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<CR>", { desc = "VimTex [T]oc" })
vim.keymap.set("n", "<leader>ld", toggle_conceallevel, { desc = "Toggle conceal level" })
vim.keymap.set({ "n", "v" }, "<leader>lj", "Jgqq", { desc = "Join and format" })
---@diagnostic enable: missing-fields

-- CHAPTER: LaTeX targets:
-- $ -> Math environments: $...$, \[ ... \]
-- c -> Commandes: \textbf{}
-- e -> LaTeX environments: \begin{align} ... \end{align}
--  TODO: Delimeters

vim.keymap.set("n", "sd$", "<plug>(vimtex-env-delete-math)")
vim.keymap.set("n", "sc$", "<plug>(vimtex-env-change-math)")
vim.keymap.set("n", "sdc", "<plug>(vimtex-cmd-delete)")
vim.keymap.set("n", "scc", "<plug>(vimtex-cmd-change)")
vim.keymap.set("n", "sde", "<plug>(vimtex-env-delete)")
vim.keymap.set("n", "sce", "<plug>(vimtex-env-change)")

-- vim.keymap.set("n", "sdd", "<plug>(vimtex-delim-delete)")
-- vim.keymap.set("n", "scd", "<plug>(vimtex-delim-change-math)")
-- vim.keymap.set("n", "std", "<plug>(vimtex-delim-toggle-modifier)")
-- vim.keymap.set("x", "std", "<plug>(vimtex-delim-toggle-modifier)")
-- vim.keymap.set("n", "stD", "<plug>(vimtex-delim-toggle-modifier-reverse)")
-- vim.keymap.set("x", "stD", "<plug>(vimtex-delim-toggle-modifier-reverse)")

-- Toggle star
vim.keymap.set("n", "stc", "<plug>(vimtex-cmd-toggle-star)")
vim.keymap.set("n", "ste", "<plug>(vimtex-env-toggle-star)")

-- vim.keymap.set("n", "st$", "<plug>(vimtex-env-toggle-math)")
-- vim.keymap.set("n", "stf", "<plug>(vimtex-cmd-toggle-frac)")
-- vim.keymap.set("x", "stf", "<plug>(vimtex-cmd-toggle-frac)")

-- CHAPTER: Exploit the power of mini.surround
local surround = require("mini.surround")
local opts = surround.config or {}
opts.custom_surroundings = vim.tbl_extend("force", opts.custom_surroundings or {}, {
	-- Environment: \begin{...}\end{...}
	e = {
		output = function()
			local name = vim.fn.input("Environment name: ")
			if name == "" then
				return nil
			end
			return {
				left = "\\begin{" .. name .. "}\n",
				right = "\n\\end{" .. name .. "}",
			}
		end,
	},

	-- Command: \command{...}
	c = {
		output = function()
			local name = vim.fn.input("Command name (without \\): ")
			if name == "" then
				return nil
			end
			return { left = "\\" .. name .. "{", right = "}" }
		end,
	},

	-- LaTeX display math: \[ ... \]
	m = {
		input = { "\\%[().-()\\%]" }, -- detect \[ ... \]
		output = { left = "\\[\n", right = "\n\\]" },
	},

	-- Bold: \textbf{...}
	b = {
		input = { "%f[%w]\\textbf%b{}" },
		output = { left = "\\textbf{", right = "}" },
	},

	-- Emphasis / italics: \emph{...}
	i = {
		input = { "%f[%w]\\emph%b{}" },
		output = { left = "\\emph{", right = "}" },
	},

	-- Underline: \underline{...}
	u = {
		input = { "%f[%w]\\underline%b{}" },
		output = { left = "\\underline{", right = "}" },
	},
})

-- CHAPTER: Enhances %
vim.keymap.set("n", "%", "<plug>(vimtex-%)")
vim.keymap.set("x", "%", "<plug>(vimtex-%)")
vim.keymap.set("o", "%", "<plug>(vimtex-%)")

-- CHAPTER: Text objects
local modes = { "x", "o" } -- Visual and operator pending

local tex_objects = {
	["$"] = "(vimtex-$)", -- math zones
	e = "(vimtex-e)", -- environments
	c = "(vimtex-c)", -- commands
	d = "(vimtex-d)", -- delimiters
	P = "(vimtex-P)", -- paragraphs
	m = "(vimtex-m)", -- items
}

for _, mode in ipairs(modes) do
	for key, plug in pairs(tex_objects) do
		vim.keymap.set(mode, "i" .. key, "<plug>" .. plug:gsub("%-", "-i"))
		vim.keymap.set(mode, "a" .. key, "<plug>" .. plug:gsub("%-", "-a"))
	end
end
