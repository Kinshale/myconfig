-- TITLE: LSP Plugins
-- + neovim/nvim-lspconfig: The main plugin for configuring LSP servers.
-- + williamboman/mason.nvim: A GUI for managing LSP servers, linters, formatters, etc.
-- + hrsh7th/nvim-cmp: Completion engine with firendly-snippets as a dependency.
-- + Other plugins for gluing them toghether

-- IDEA:
-- LSPs auto-attach because of your mason-lspconfig config block. So once you download a Language Server with Mason you're fine.
-- Formatters and Linters (e.g. Prettier, Black, Stylua, etc.) require explicit mapping in plugins/format.lua.

return {
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			{ "j-hui/fidget.nvim", opts = {} },
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
			},
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- CHAPTER: Set up Mason and language servers (automatic installation).

			local capabilities = vim.lsp.protocol.make_client_capabilities() -- Hover, autocompletion integration, definitions are basic capabilities.
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "pyright", "lua_ls", "stylua" },
				automatic_installation = true,
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({ capabilities = capabilities })
					end,
				},
			})

			-- CHAPTER: Configuring Diagnostics.

			vim.diagnostic.config({
				signs = {
					text = { Error = "", Info = "󰋽", Warn = "", Hint = "󱠃" },
				},
				virtual_text = true,
				float = { border = "single" },
				update_in_insert = false,
				underline = true,
				severity_sort = true,
			})

			-- -- Configure hover appearance
			-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			-- 	border = "single",
			-- })

			-- CHAPTER: LSP keymaps

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local bufnr = event.buf
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
					end

					-- Basic navigation
					map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype definition") -- FIX: Conflicts with goto_next tab.
					map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
					map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

					-- Actions
					map("<leader>ar", vim.lsp.buf.rename, "[R]ename")
					map("<leader>af", vim.lsp.buf.format, "[F]ormat")
					map("<leader>al", "<cmd>LspRestart<CR>", "Restart [L]sp")
					map("<leader>ac", vim.lsp.buf.code_action, "[C]ode", { "n", "x" })

					-- Buffer.
					map("<leader>bs", require("telescope.builtin").lsp_document_symbols, "[B]uffer [S]ymbols")
					map("<leader>bd", require("telescope.builtin").diagnostics, "[B]uffer [D]iagnostics")
					map("<leader>bq", vim.diagnostic.setqflist, "[Q]uickfix list")

					-- Workspace
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Toggling
					map("<leader>td", function()
						vim.diagnostic.enable(not vim.diagnostic.is_enabled())
					end, "[T]oggle [D]iagnostic")

					map("<leader>tl", function()
						local clients = vim.lsp.get_clients({ bufnr = 0 })
						if #clients > 0 then
							vim.cmd("LspStop")
							print("LSP stopped")
						else
							vim.cmd("LspStart")
							print("LSP started")
						end
					end, "[T]oggle [L]sp")

					-- Documentation
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("H", vim.diagnostic.open_float, "Hover Diagnostic")

					-- Diagnostic navigation
					map("]d", vim.diagnostic.goto_next, "Next [D]iagnostic")
					map("[d", vim.diagnostic.goto_prev, "Previous [D]iagnostic")

					-- DOUBT: What's the purpose of this?
					-- map("<leader>fr", require("telescope.builtin").lsp_references, "[F]ind [R]eferences")

					-- CHAPTER: Document highlighting (when hovering a variable it highlights other occurences).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end
				end,
			})
		end,
	},

	{ -- CHAPTER: Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{
						name = "lazydev",
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},
}
