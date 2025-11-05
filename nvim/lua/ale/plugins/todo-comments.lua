return {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = false, -- hide icons in sign column for a cleaner look
		merge_keywords = false, -- use only the defined semantics below

		keywords = {
			TITLE = {
				color = "header",
				alt = { "HEADER" },
			},
			CHAPTER = {
				color = "subheader",
				alt = {},
			},
			LINK = {
				color = "link",
				alt = { "" },
			},
			NOTE = {
				color = "note",
				alt = { "USE" },
			},
			IDEA = {
				color = "idea",
				alt = { "KEY-IDEA", "INSIGHT" },
			},
			TODO = {
				color = "todo",
				alt = {},
			},
			DOUBT = {
				color = "doubt",
				alt = { "QUESTION", "REVIEW" },
			},
			FIX = {
				color = "fix",
				alt = { "ERROR", "BUG" },
			},
			WARNING = {
				color = "warning",
				alt = { "ATTENTION", "README" },
			},
		},

		-- 🎨 Elegant & expressive color theme (dark-mode optimized)
		colors = {
			header = { "#7dcfff" }, -- Kept your original, it's a good bright blue
			subheader = { "#7aa2f7" }, -- A softer, distinctive purple
			link = { "#00B7FF" },
			note = { "#9ece6a" }, -- A brighter, more vibrant green
			idea = { "#2ac3de" }, -- Your original "idea" cyan, now for "subheader"
			todo = { "#bb9af7" }, -- Your original "todo" purple, now for "idea"
			doubt = { "#ff9e64" }, -- Vibrant orange
			fix = { "#f7768e" }, -- Unchanged, it's excellent
			warning = { "#e0af68" }, -- Warm, noticeable amber
		},

		-- TITLE:
		-- CHAPTER:
		-- LINK:
		-- NOTE:
		-- IDEA:
		-- TODO:
		-- DOUBT:
		-- ERROR:
		-- WARNING:

		highlight = {
			multiline = false,
			comments_only = true,
			keyword = "wide_bg", -- highlight the full keyword with background
			after = "fg",
		},

		search = {
			pattern = [[(?i)\b(KEYWORDS)\b]],
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
		},
	},
}
